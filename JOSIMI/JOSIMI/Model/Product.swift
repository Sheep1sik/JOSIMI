//
//  Product.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import Foundation

// Product 모델 정의
struct Product: Decodable, Identifiable {
    let id: Int64               // Long 타입을 Int64로 매핑
    let productCategory: String
    let productName: String
    let productPrice: Decimal   // BigDecimal 타입을 Decimal로 매핑
    let productImageLink: String
    let productPurchaseLink: String
    let productType: String
    let productCode: String?    // Null 값을 허용하기 위해 Optional로 변경
    let ingredientResponses: [Ingredient]  // Ingredient 배열

    // 사용자 정의 이니셜라이저 추가
    init(id: Int64,
         productCategory: String,
         productName: String,
         productPrice: Decimal,
         productImageLink: String,
         productPurchaseLink: String,
         productType: String,
         productCode: String? = nil,
         ingredientResponses: [Ingredient]) {
        self.id = id
        self.productCategory = productCategory
        self.productName = productName
        self.productPrice = productPrice
        self.productImageLink = productImageLink
        self.productPurchaseLink = productPurchaseLink
        self.productType = productType
        self.productCode = productCode
        self.ingredientResponses = ingredientResponses
    }
}


