//
//  RecommendedProductScrollView.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import SwiftUI

struct RecommendedProductScrollView: View {
    @StateObject private var viewModel = RecommendedProductViewModel()
    @State private var isPressed = false
    
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.productAfters) { product in
                        RecommendedProductItemView(productAfter: product)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                isPressed = true
            }, label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 766, height: 40)
                    .overlay {
                        Text("건강한 제품 더 보기")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
            })
        }
        .navigationDestination(isPresented: $isPressed) {
            RecommendedProductListView()
                .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            viewModel.fetchProducts() // 뷰가 나타날 때 데이터를 가져옴
        }
    }
}



#Preview {
    RecommendedProductScrollView()
}
