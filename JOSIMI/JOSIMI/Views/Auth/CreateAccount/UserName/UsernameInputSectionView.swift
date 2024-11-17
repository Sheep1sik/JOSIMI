//
//  UsernameInputSectionView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

// MARK: - 유저 이름 입력창
struct UsernameInputSectionView: View {
    @Binding var username: String
    let characterLimit: Int
    let strokeColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(strokeColor, lineWidth: 2)
                .frame(height: 52)
                .animation(.easeInOut, value: strokeColor) // 테두리 색상 애니메이션
            
            HStack {
                TextField("닉네임", text: $username)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .onChange(of: username) { newValue in
                        if newValue.count > characterLimit {
                            username = String(newValue.prefix(characterLimit))
                        } // 
                    }
                
                Spacer()
                
                Text("\(username.count) / \(characterLimit)")
                    .foregroundColor(username.count > characterLimit ? .orange : Color(.systemGray3))
                    .padding(.trailing)
            }
            .padding(.horizontal, 8)
        }
    }
}


#Preview {
    UsernameInputSectionView(username: .constant(""), characterLimit: 10, strokeColor: Color.gray)
}
