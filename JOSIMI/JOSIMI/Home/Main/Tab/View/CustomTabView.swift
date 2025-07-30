//
//  CustomTabView.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI


struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedCorners(radius: 30, corners: [.topLeft, .topRight])
                    .frame(height: 78)
                    .foregroundColor(.white)
                    .shadow(color: Color(.systemGray6), radius: 3, y: -2)
                    .overlay {
                        HStack(alignment: .center) {
                            Spacer()
                            // 성분분석
                            VStack {
                                Button {
                                    //selectedTab = .analysis
                                } label: {
                                    selectedTab == .analysis ? ButtonView(imageName: "analysis_togle") : ButtonView(imageName: "analysis")
                                }
                                
                                Text("성분분석")
                                    .font(.system(size: 12))
                                    .foregroundColor(selectedTab == .analysis ? .accentColor : .gray)
                            }
                            Spacer()
                            
                            // 찜목록
                            VStack {
                                Button {
                                    //selectedTab = .wishList
                                } label: {
                                    selectedTab == .wishList ? ButtonView(imageName: "wishList_togle") : ButtonView(imageName: "wishList")
                                }
                                
                                Text("찜목록")
                                    .font(.system(size: 12))
                                    .foregroundColor(selectedTab == .wishList ? .accentColor : .gray)
                            }
                            
                            Spacer()
                            
                            // 홈
                            VStack {
                                Button {
                                    selectedTab = .home
                                } label: {
                                    selectedTab == .home ? ButtonView(imageName: "home_togle") : ButtonView(imageName: "home")
                                }
                                
                                Text("홈")
                                    .font(.system(size: 12))
                                    .foregroundColor(selectedTab == .home ? .accentColor : .gray)
                            }
                            Spacer()
                            
                            // 상점
                            VStack {
                                Button {
                                    //selectedTab = .store
                                } label: {
                                    selectedTab == .store ? ButtonView(imageName: "store_togle") : ButtonView(imageName: "store")
                                }
                                
                                Text("상점")
                                    .font(.system(size: 12))
                                    .foregroundColor(selectedTab == .store ? .accentColor : .gray)
                            }
                            Spacer()
                            
                            // 마이페이지
                            VStack {
                                Button {
                                    //selectedTab = .user
                                } label: {
                                    selectedTab == .user ? ButtonView(imageName: "user_togle") : ButtonView(imageName: "user")
                                }
                                
                                Text("마이페이지")
                                    .font(.system(size: 12))
                                    .foregroundColor(selectedTab == .user ? .accentColor : .gray)
                            }
                            Spacer()
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom) // 안전 영역 무시하여 가장 하단으로
    }
}

#Preview {
    CustomTabView(selectedTab: .constant(.home))
}
