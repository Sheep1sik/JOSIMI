//
//  HomeView.swift
//  Josimi
//
//  Created by 양원식 on 8/21/24.
//

import SwiftUI


struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    var body: some View {
            VStack {
                // 상단 타이틀
                HStack {
                    Text("조시미")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        print("선택 클릭")
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .frame(width: 60, height: 30)
                            .overlay{
                                Text("당뇨")
                                    .fontWeight(.bold)
                            }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        print("알람 클릭")
                        isLoggedIn = false // 회원가입이 완료되었으므로 로그인 상태를 true로 변경
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("bx-bell.svg")
                    })
                    
                    Button(action: {
                        print("장바구니 클릭")
                    }, label: {
                        Image("bx-basket.svg")
                    })
                }
                // 검색창
                SearchBarView()
            }
            .padding(.horizontal, 20)
            
            Divider()
            
            ScrollView {
                // 광고창
                ADBannerView()
                
                VStack {
                    // 나를 위한 건강한 제품
                    VStack {
                        HStack {
                            (Text("나를 위한 ")+Text("건강한 제품").bold()).font(.title2)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        RecommendedProductScrollView()
                    }
                    
                    // 나를 위한 건강한 정보
                    VStack {
                        HStack {
                            (Text("나를 위한 ") + Text("건강한 정보").bold())
                                .font(.title2)
                            Spacer()
                            Text("더보기")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .padding(.horizontal, 20)
                        Image("image1")
                    }
                    .padding(.top, 28)
                    
                    
                    // ZERO에 대한 다양한 견해
                    VStack {
                        HStack {
                            (Text("ZERO").bold() + Text("에 대한 다양한 견해"))
                                .font(.title2)
                            Spacer()
                            Text("더보기")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .padding(.horizontal, 20)
                        HStack {
                            Image("ZERO1")
                            Image("ZERO2")
                                .padding(.leading, -20)
                        }
                    }
                    .padding(.top, 28)
                    
                    // 차곡차곡 포인트
                    VStack {
                        HStack {
                            (Text("차곡차곡 ") + Text("포인트").bold())
                                .font(.title2)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        Image("Point")
                    }
                    .padding(.top, 28)
                }
                
            }
    }
}

#Preview {
    HomeView()
}
