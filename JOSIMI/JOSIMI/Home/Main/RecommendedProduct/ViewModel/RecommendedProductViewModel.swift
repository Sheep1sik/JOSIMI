//
//  RecommendedProductViewModel.swift
//  Josimi
//
//  Created by 양원식 on 9/22/24.
//

import SwiftUI
import Combine

class RecommendedProductViewModel: ObservableObject {
    @Published var productCategorys: [ProductCategory] = [] // ProductCategory 배열
    @Published var product: Product?
    @Published var productAfters: [ProductAfter] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchProducts()
    }
    
    // After 타입 제품을 가져오는 함수
    func fetchProducts() {
        guard let url = URL(string: "http://3.106.54.177:8080/api/products/productTypes/After") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: [ProductAfter].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    break
                }
            }, receiveValue: { [weak self] products in
                // `productName`이 "곡물원 잡곡밥 곡물톡톡 병아리콩 귀리"인 제품을 첫 번째로, 나머지 무작위로 섞기
                var shuffledProducts = products.shuffled()
                if let index = shuffledProducts.firstIndex(where: { $0.productName == "곡물원 잡곡밥 곡물톡톡 병아리콩 귀리" }) {
                    let firstProduct = shuffledProducts.remove(at: index)
                    shuffledProducts.insert(firstProduct, at: 0)
                }
                self?.productAfters = shuffledProducts
            })
            .store(in: &cancellables)
    }

    
    // 특정 제품 이름을 사용하여 제품 정보를 가져오는 함수
    func fetchProductDetails(productName: String) {
        guard let url = URL(string: "http://3.106.54.177:8080/api/products/productNames/\(productName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }

            guard let data = data else {
                return
            }

            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                DispatchQueue.main.async {
                    self.product = product
                }
            } catch {
                return
            }
        }.resume()
    }

    // 특정 카테고리에 속하는 제품 목록을 가져오는 함수
    func fetchProductsByCategory(categoryName: String) {
        guard let encodedCategory = categoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://3.106.54.177:8080/api/products/categories/\(encodedCategory)") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: [ProductCategory].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    break
                }
            }, receiveValue: { [weak self] categories in
                self?.productCategorys = categories
            })
            .store(in: &cancellables)
    }

    // 구글 드라이브 이미지 URL을 직접 접근 가능한 URL로 변환하는 함수
    func getDirectImageUrl(from url: URL) -> URL? {
        let googleDrivePattern = #"https://drive.google.com/file/d/([^/]*)/.*"#
        let regex = try? NSRegularExpression(pattern: googleDrivePattern, options: [])
        
        if let match = regex?.firstMatch(in: url.absoluteString, options: [], range: NSRange(location: 0, length: url.absoluteString.utf16.count)),
           let range = Range(match.range(at: 1), in: url.absoluteString) {
            let fileId = String(url.absoluteString[range])
            let directImageUrlString = "https://drive.google.com/uc?export=view&id=\(fileId)"
            return URL(string: directImageUrlString)
        }
        return nil
    }
    
    // 가격 포맷 함수
    func formatPrice(_ price: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: price as NSDecimalNumber) ?? "\(price)"
    }
}
