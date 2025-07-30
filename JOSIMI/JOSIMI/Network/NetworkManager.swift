//
//  NetworkManager.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://3.106.54.177:8080/api/products/productNames/"
    
    func fetchProducts(productName: String) async throws -> [Product] {
        guard let encodedProductName = productName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            throw URLError(.badURL)
        }
        
        let urlString = baseURL + encodedProductName
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let products = try decoder.decode([Product].self, from: data)
        
        let filteredProducts = products.filter { $0.productType.lowercased() == "after" }
        
        return filteredProducts
    }
}

