//
//  GreetingSectionView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

struct GreetingSectionView: View {
    @State var greetingTop: String
    @State var greetingBottom: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(greetingTop) // 상단 인사말
                Text(greetingBottom) // 하단 인사말
            }
            .fontWeight(.bold)
            .font(.title3)
            Spacer()
        }
    }
}

#Preview {
    GreetingSectionView(greetingTop: "반갑습니다!", greetingBottom: "닉네임을 입력해주세요.")
}
