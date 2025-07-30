//
//  ProductCategory.swift
//  Josimi
//
//  Created by 양원식 on 9/22/24.
//

import Foundation

struct ProductCategory: Identifiable, Decodable {
    let id: Int64 // "Long" 타입은 Int64로 매핑
    let productCategory: String
    let productName: String
    let productPrice: Decimal // "BigDecimal" 타입은 Decimal로 매핑
    let productImageLink: String
    let productPurchaseLink: String
    let productType: String
    let productCode: String?
}
