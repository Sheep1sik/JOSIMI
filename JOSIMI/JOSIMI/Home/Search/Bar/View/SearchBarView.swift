//
//  SearchBar.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

struct SearchBarView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color.gray, lineWidth: 1)
                .frame(height: 40)
                .overlay {
                    HStack {
                        Text("검색어를 입력해주세요.")
                            .foregroundColor(Color.gray)
                        Spacer()
                        // 검색 아이콘
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.gray)
                    }
                    .padding()
                }
        }
        .padding(.top, 5)
        
        
    }
}

#Preview {
    SearchBarView()
}
