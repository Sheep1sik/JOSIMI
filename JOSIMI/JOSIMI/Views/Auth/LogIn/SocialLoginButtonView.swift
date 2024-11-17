//
//  SocialLoginButtonView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

// MARK: - 로그인 버튼
struct SocialLoginButtonView: View {
    
    let imageName: String // 로그인 버튼 이미지 이름
    let action: () -> Void // print
    let buttonWidth: CGFloat // 버튼 가로 길이
    
    var body: some View {
        Button(action: action) {
            // 로고 이미지
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: buttonWidth, height: 45)
        }
    }
}

#Preview {
    SocialLoginButtonView(imageName: "kakao_login_medium_wide", action: { print("애플 로그인 버튼 클릭") }, buttonWidth: UIScreen.main.bounds.size.width * 0.8)
}
