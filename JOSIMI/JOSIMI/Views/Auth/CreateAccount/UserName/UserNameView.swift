//
//  UserNameView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

struct UserNameView: View {
    @StateObject private var viewModel = UserNameViewModel() // 뷰 모델 생성

    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - 인사말
            GreetingSectionView(
                greetingTop: "반갑습니다!",
                greetingBottom: "닉네임을 입력해주세요."
            )
            
            // MARK: - 닉네임 입력 구간
            UsernameInputSectionView(
                username: $viewModel.username,
                characterLimit: 10,
                strokeColor: viewModel.strokeColor
            )
            
            // MARK: - 오류 메시지
            if let errorMessage = viewModel.errorMessage {
                ErrorMessageView(message: errorMessage)
            }
            
            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: viewModel.validationStatus)
    }
    
}



#Preview {
    UserNameView()
}
