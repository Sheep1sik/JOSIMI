//
//  BarcodeScannerViewModel.swift
//  Josimi
//
//  Created by 양원식 on 9/20/24.
//

import SwiftUI
import AVFoundation
import Combine

class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode: String = ""
    // 13자리 바코드 각각의 값을 관리하는 상태 변수
    @Published var digits: [String] = Array(repeating: "", count: 13)
    @Published var product: Product? // API로 불러온 제품 정보를 저장하는 상태 변수
    
    private var cancellables = Set<AnyCancellable>()
    
    // 스캔된 코드 업데이트
    func updateScannedCode(with code: String) {
        scannedCode = code
    }
    
    // digits 배열을 합쳐서 viewModel.scannedCode에 숫자로 저장하는 함수
    func updateDigitsCode() {
        let joinedDigits = digits.joined()
        scannedCode = joinedDigits
    }
    
    // API 호출 함수: 스캔된 바코드로 제품 정보를 가져옴
    func fetchProductDetails(completion: @escaping (Product?) -> Void) {
        // 스캔된 코드가 13자리인지 확인
        guard scannedCode.count == 13, let url = URL(string: "http://3.106.54.177:8080/api/products/productCodes/\(scannedCode)") else {
            print("Invalid barcode or URL.")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                }
            }
        }.resume()

        
        // API 호출
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Product.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .failure(let error):
                    print("Failed to fetch product details: \(error)")
                    completion(nil)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] product in
                self?.product = product
                completion(product)
            })
            .store(in: &cancellables)
    }
}
