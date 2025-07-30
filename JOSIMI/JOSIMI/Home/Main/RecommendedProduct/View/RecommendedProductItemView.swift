//
//  RecommendedProductItemView.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import SwiftUI

struct RecommendedProductItemView: View {
    @StateObject var viewModel = RecommendedProductViewModel()
    var productAfter: ProductAfter
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            viewModel.fetchProductDetails(productName: productAfter.productName)
            isPressed = true
        }, label: {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
                .shadow(color: Color(.systemGray6) ,radius: 5, x: 5 , y: 15)
                .frame(width: 150, height: 180)
                .overlay {
                    VStack {
                        if let originalUrl = URL(string: productAfter.productImageLink) {
                            if let imageUrl = viewModel.getDirectImageUrl(from: originalUrl) {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 120, height: 120)
                                }placeholder: {
                                    ProgressView()
                                }
                            } else {
                                AsyncImage(url: originalUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 120, height: 120)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }else {
                            Text("Invalid URL")
                        }
                        Text(productAfter.productName)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                }
        })
        .navigationDestination(isPresented: $isPressed) {
            if let product = viewModel.product {
                ProductDetailsPageView(product: product)
                    .navigationBarBackButtonHidden(true)
            } else {
                Text("Product details not available.")
            }
        }
    }
}



struct RecommendedProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyProduct = ProductAfter(
            id: 1,
            productCategory: "과자",
            productName: "빈츠 비스켓, 76g, 1개",
            productPrice: 5200.00,
            productImageLink: "https://shopping-phinf.pstatic.net/main_4423509/44235098705.20231124182805.jpg?type=f640",
            productPurchaseLink: "https://www.coupang.com/vp/products/4590016491?itemId=1053867&vendorItemId=83804446130&q=%EA%B3%BC%EC%9E%90&itemsCount=36&searchId=8f140db00b9d4735946f306de98101a0&rank=16&isAddedCart=",
            productType: "Before",
            productCode: "8801062634453"
        )
        
        RecommendedProductItemView(viewModel: RecommendedProductViewModel(), productAfter: dummyProduct)
    }
}
