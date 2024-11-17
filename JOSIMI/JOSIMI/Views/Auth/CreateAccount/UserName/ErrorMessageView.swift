//
//  ErrorMessageView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

// MARK: - ERROR 메세지
struct ErrorMessageView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.orange)
            .font(.footnote)
            .padding(.leading, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .transition(.opacity) // 메시지 전환 애니메이션
    }
}


#Preview {
    ErrorMessageView(message: "에러메세지")
}
