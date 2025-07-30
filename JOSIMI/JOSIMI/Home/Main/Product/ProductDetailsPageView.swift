//
//  ProductDetailsPage.swift
//  Josimi
//
//  Created by 양원식 on 9/21/24.
//

import SwiftUI

struct ProductDetailsPageView: View {
    @StateObject var viewModel = RecommendedProductViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isPressed = false
    var product: Product // 검색된 제품 정보
    
    // 위험, 조심, 안전한 상품 리스트
    let dangerousProducts = ["빈츠 비스켓, 76g, 1개", "코카콜라 캔"]
    let cautionProducts = ["칠성사이다 제로", "코카콜라 제로", "클룹 제로소다 복숭아", "탐스 제로 파인애플", "밀키스 제로", "스톡웨더스 오리지널 무설탕 초코맛 캔디", "코피코 슈가프리 커피맛 캔디", "롯데웰푸드 제로 마일드 초콜릿 50g / 설탕제로 무설탕, 50", "제로 크런치 초코볼 10p, 140g", "초코러브 XO 솔티드 피넛 버터 인 37퍼센트 밀크 초콜릿 노 슈가 애디드", "Russell Stover 슈가 프리 밀크 초콜릿 카라멜 타일 바 85g 364990, 85g"]
    let safeProducts = ["이클립스 페퍼민트향 캔디", "인테이크 슈가로로 스파클링 복숭아", "졸리팝 무설탕 막대사탕", "닥터존스 클래식 프루트 롤리팝", "무설탕 스위스 허브캔디 리콜라 크랜베리", "레몬향 자일리톤 스톤", "린트 Lindt 무설탕 다크 초콜릿, 100g", "Lindt 린트 밀크 초콜릿 무설탕 글루텐 프리, 100g", "Natra 벨기에 나트라 무설탕 트러플스 커피 초콜릿 150g", "코니 무설탕 초콜릿 시리얼바, 120g", "곡물원 잡곡밥 곡물톡톡 병아리콩 귀리"]
    
    var body: some View {
        VStack {
            ZStack {
                // 상단 바
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    })
                    Button(action: {}, label: {
                        Image("home2")
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image("share")
                    })
                    Button(action: {}, label: {
                        Image("kid_star")
                    })
                    Button(action: {}, label: {
                        Image("shopping_cart")
                    })
                    
                }
                .padding(.horizontal, 20)
                
                // ZStack의 중앙에 텍스트를 배치
                Text("제품 정보")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, maxHeight: 44) // 높이와 너비를 설정하여 HStack과 Text의 레이아웃을 일치시킴
            
            ScrollView {
                if let originalUrl = URL(string: product.productImageLink) {
                    // Google Drive URL 체크를 위한 정규식
                    let googleDrivePattern = #"https://drive.google.com/file/d/([^/]*)/.*"#
                    let regex = try? NSRegularExpression(pattern: googleDrivePattern, options: [])
                    
                    // Google Drive URL일 경우
                    if let match = regex?.firstMatch(in: originalUrl.absoluteString, options: [], range: NSRange(location: 0, length: originalUrl.absoluteString.utf16.count)),
                       let range = Range(match.range(at: 1), in: originalUrl.absoluteString) {
                        let fileId = String(originalUrl.absoluteString[range])
                        let directImageUrlString = "https://drive.google.com/uc?export=view&id=\(fileId)"
                        
                        if let imageUrl = URL(string: directImageUrlString) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 250, height: 235)
                        } else {
                            Text("Invalid URL")
                        }
                    }
                    // 일반 웹 URL일 경우
                    else {
                        AsyncImage(url: originalUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 250, height: 235)
                    }
                } else {
                    Text("Invalid URL")
                }
                
                VStack(spacing: 10) {
                    // 카테고리
                    HStack {
                        Text(product.productCategory)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        Spacer()
                    }
                    
                    // 제품 이름
                    HStack {
                        Text(product.productName)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    // 가격
                    HStack {
                        Text("\(viewModel.formatPrice(product.productPrice))원")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    // 조시미 요약
                    HStack {
                        // 상품 이름에 따른 이미지 선택
                        if dangerousProducts.contains(product.productName) {
                            Image("DescriptionRed")
                        } else if cautionProducts.contains(product.productName) {
                            Image("DescriptionYellow")
                        } else if safeProducts.contains(product.productName) {
                            Image("DescriptionGreen")
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                
                Divider()
                
                VStack(spacing: 20) {
                    HStack {
                        Image("Description2")
                        Spacer()
                    }
                    
                    RiskView(circleColor: .red, riskLevelText: "높은 위험", riskNumberColor: .red, ingredients: product.ingredientResponses, imageName: "redIcon")
                    
                    Divider()

                    
                    RiskView(circleColor: .yellow, riskLevelText: "주의 위험", riskNumberColor: .yellow, ingredients: product.ingredientResponses, imageName: "yellowIcon")
                    
                    Divider()
                    
                    RiskView(circleColor: .green, riskLevelText: "낮은 위험", riskNumberColor: .green, ingredients: product.ingredientResponses, imageName: "greenIcon")

                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                }
            Divider()

            // 조시미 추천 제품 보러가기 버튼
            if product.productType == "After" {
                Button(action: {
                    if let url = URL(string: product.productPurchaseLink) {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 766, height: 40)
                        .overlay {
                            Text("제품 구매하기")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                })
                Spacer()
            } else {
                HStack {
                    Button(action: {
                        if let url = URL(string: product.productPurchaseLink) {
                                UIApplication.shared.open(url)
                            }
                    }, label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 370, height: 40)
                            .overlay {
                                Text("제품 구매하기")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                    })
                    Spacer()
                    Button(action: {
                        isPressed = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 370, height: 40)
                            .overlay {
                                Text("조시미 추천 제품 보러가기")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                    })
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .navigationDestination(isPresented: $isPressed) {
            RecommendedProductCategoryListView(categoryName: product.productCategory)
                .navigationBarBackButtonHidden(true)
        }
    }
    
}



struct ProductDetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyProduct = Product(
            id: 1,
            productCategory: "과자",
            productName: "빈츠 비스켓, 76g, 1개",
            productPrice: 5200.00,
            productImageLink: "https://shopping-phinf.pstatic.net/main_4423509/44235098705.20231124182805.jpg?type=f640",
            productPurchaseLink: "https://www.coupang.com/vp/products/4590016491?itemId=1053867&vendorItemId=83804446130&q=%EA%B3%BC%EC%9E%90&itemsCount=36&searchId=8f140db00b9d4735946f306de98101a0&rank=16&isAddedCart=",
            productType: "Before",
            productCode: "8801062634453",
            ingredientResponses: [
                Ingredient(id: 1, ingredientName: "준초콜릿", ingredientDescription: "풍부한 항산화 물질로 피부 건강 및 스트레스 완화에 도움", riskDegree: "HIGH"),
                Ingredient(id: 2, ingredientName: "설탕", ingredientDescription: "에너지원으로 사용되며 단맛 제공, 과다 섭취 시 건강에 해로울 수 있음", riskDegree: "LOW"),
                Ingredient(id: 3, ingredientName: "코코아퍼퍼레이션", ingredientDescription: "항산화 작용과 혈압 조절, 심장 건강에 도움", riskDegree: "MIDDLE")
            ]
        )
        
        ProductDetailsPageView(product: dummyProduct)
    }
}
