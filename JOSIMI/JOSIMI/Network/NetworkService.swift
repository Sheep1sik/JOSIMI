//
//  NetworkService.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import Foundation

protocol NetworkService {
    func fetchProducts(productName: String) async throws -> [Product]
}

