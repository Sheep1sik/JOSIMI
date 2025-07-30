//
//  TabbarView.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

enum Tab {
    case home
    case wishList
    case analysis
    case store
    case user
}

struct TabbarView: View {
    @State var selectedTab: Tab = .home
    
    var body: some View {
        VStack {
            // 화면의 주요 콘텐츠를 표시하는 영역
            switch selectedTab {
            case .home:
                ZStack {
                    VStack {
                        HomeView()
                    }
                    DraggableButton()
                }
            case .wishList:
                HomeView()
            case .analysis:
                HomeView()
            case .store:
                HomeView()
            case .user:
                HomeView()
            }
            
            Spacer() // 콘텐츠와 탭바 사이의 간격을 위한 Spacer
            
            // CustomTabView는 하단에 고정
            CustomTabView(selectedTab: $selectedTab)
                .frame(height: 78) // 탭바 높이를 지정하여 화면을 덮지 않도록 함
        }
        .edgesIgnoringSafeArea(.bottom) // 탭바가 안전 영역을 넘어 표시되도록 설정
    }
}

#Preview {
    TabbarView()
}
