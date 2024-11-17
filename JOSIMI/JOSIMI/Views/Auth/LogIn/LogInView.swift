//
//  LoginView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

// MARK: - 로그인 뷰
struct LogInView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // 로고 뷰
            LogoView(size: UIScreen.main.bounds.width * 0.3)
            
            Spacer()
            
            // 로그인 버튼
            VStack {
                // Kakao 로그인
                SocialLoginButtonView(
                    imageName: "kakao_login_medium_wide",
                    action: { print("카카오 로그인 버튼 클릭") },
                    buttonWidth: UIScreen.main.bounds.width * 0.8
                )
                
                // Apple 로그인
                SocialLoginButtonView(
                    imageName: "kakao_login_medium_wide",
                    action: { print("카카오 로그인 버튼 클릭") },
                    buttonWidth: UIScreen.main.bounds.width * 0.8
                )
            }
            .padding(.bottom, UIScreen.main.bounds.height * 0.0739) // 하단 패딩 유지
        }
    }
}

#Preview {
    LogInView()
}
