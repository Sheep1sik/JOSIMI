//
//  RecommendedProductNormalItemView.swift
//  Josimi
//
//  Created by 양원식 on 9/22/24.
//

import SwiftUI

struct RecommendedProductNormalItemView: View {
    @StateObject private var viewModel = RecommendedProductViewModel()
    var productAfter: ProductAfter
    @State var heartIsTogle = false
    @State var plsuIsTogle = false
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            ZStack {
                Button(action: {
                    viewModel.fetchProductDetails(productName: productAfter.productName)
                    isPressed = true
                }, label: {
                VStack {
                    if let originalUrl = URL(string: productAfter.productImageLink) {
                        if let imageUrl = viewModel.getDirectImageUrl(from: originalUrl) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 167, height: 160)
                            }placeholder: {
                                ProgressView()
                            }
                        } else {
                            AsyncImage(url: originalUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 167, height: 160)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }else {
                        Text("Invalid URL")
                    }
                    VStack(alignment: .leading) {
                        Text(productAfter.productName)
                        
                        Text(viewModel.formatPrice(productAfter.productPrice))
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                })
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            plsuIsTogle = !plsuIsTogle
                        }, label: {
                            Image(systemName: plsuIsTogle ? "checkmark.circle.fill" : "plus.circle.fill")
                                .resizable()
                                .foregroundColor(plsuIsTogle ? .accentColor : .gray)
                                .frame(width: 30, height: 30)
                        })
                    }
                    Spacer()
                }
                .padding(.trailing, 10)
                
                VStack {
                    HStack {
                        Button(action: {
                            heartIsTogle = !heartIsTogle
                        }, label: {
                            Image(systemName: heartIsTogle ? "heart.fill" : "heart")
                                .resizable()
                                .foregroundColor(heartIsTogle ? .red : .gray)
                                .frame(width: 30, height: 30)
                        })
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .frame(width: 170, height: 262)
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

struct RecommendedProductNormalItemView_Previews: PreviewProvider {
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
        
        RecommendedProductNormalItemView(productAfter: dummyProduct)
    }
}
