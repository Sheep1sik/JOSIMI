//
//  ProductAfter.swift
//  Josimi
//
//  Created by 양원식 on 9/22/24.
//

import Foundation

struct ProductAfter: Identifiable, Codable {
    var id: Int64 // JSON의 "Long" 타입을 Int64로 매핑
    var productCategory: String
    var productName: String
    var productPrice: Decimal // BigDecimal은 Swift에서 Decimal로 매핑
    var productImageLink: String
    var productPurchaseLink: String
    var productType: String
    var productCode: String?
}
