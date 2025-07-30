//
//  RiskView.swift
//  Josimi
//
//  Created by 양원식 on 9/22/24.
//

import SwiftUI

struct RiskView: View {
    var circleColor: Color
    var riskLevelText: String
    var riskNumberColor: Color
    var ingredients: [Ingredient]
    var imageName: String
    
    // riskLevelText에 따른 riskDegree 매핑
        func getRiskDegree(for riskLevelText: String) -> String {
            switch riskLevelText {
            case "높은 위험":
                return "HIGH"
            case "낮은 위험":
                return "LOW"
            case "주의 위험":
                return "MIDDLE"
            default:
                return ""
            }
        }
    
    var body: some View {
        let riskDegree = getRiskDegree(for: riskLevelText)
        let filteredIngredients = ingredients.filter { $0.riskDegree == riskDegree }
        let riskCount = ingredients.filter { $0.riskDegree == riskDegree }.count
        
        HStack(alignment: .top) {
            // 아이콘 + 위험수
            VStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 90, height: 40)
                    .foregroundColor(circleColor)
                    .opacity(0.07)
                    .overlay {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(circleColor)
                            Text(riskLevelText)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            
                            Text("\(riskCount)")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(riskNumberColor)
                        }
                    }
                
                Image(imageName)
                    .padding(.bottom, -7)
            }
            .padding(.trailing)
            
            VStack(alignment: .leading) {
                ForEach(filteredIngredients, id: \.id) { ingredient in
                    // 성분 이름
                    Text(ingredient.ingredientName)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .padding(.top, 5)
                    
                    // 성분 설명
                    Text(ingredient.ingredientDescription)
                        .font(.subheadline)
                }

            }
            Spacer()
        }
    }
}

#Preview {
    RiskView(
        circleColor: .red,
        riskLevelText: "높은 위험",
        riskNumberColor: .red,
        ingredients: [
            Ingredient(id: 1, ingredientName: "준초콜릿", ingredientDescription: "풍부한 항산화 물질로 피부 건강 및 스트레스 완화에 도움", riskDegree: "HIGH"),
            Ingredient(id: 2, ingredientName: "설탕", ingredientDescription: "에너지원으로 사용되며 단맛 제공, 과다 섭취 시 건강에 해로울 수 있음", riskDegree: "LOW"),
            Ingredient(id: 3, ingredientName: "코코아퍼퍼레이션", ingredientDescription: "항산화 작용과 혈압 조절, 심장 건강에 도움", riskDegree: "MIDDLE")
        ],
        imageName: "redIcon"
    )
}
