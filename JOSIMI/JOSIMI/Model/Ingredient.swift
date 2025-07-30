//
//  IngredientResponse.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import Foundation

struct Ingredient: Decodable, Identifiable {
    let id: Int64  // Long 타입을 Int64로 사용
    let ingredientName: String
    let ingredientDescription: String
    let riskDegree: String
}
