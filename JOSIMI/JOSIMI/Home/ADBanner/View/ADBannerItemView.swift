//
//  ADBannerItemView.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

// ADBannerItemView는 현재 광고 배너의 페이지 인덱스와 총 페이지 수를 표시하는 뷰입니다.
struct ADBannerItemView: View {
    // 현재 페이지 인덱스를 바인딩으로 받아옵니다.
    @Binding var pageIndex: Int
    // 총 페이지 수를 바인딩으로 받아옵니다.
    @Binding var pageTotal: Int
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                // 광고 배너(AD) 숫자 표시를 위한 캡슐 형태의 배경을 생성합니다.
                
                Spacer()
                Capsule()
                    .foregroundColor(Color(.lightGray)) // 배경 색상 설정
                    .frame(width: 50, height: 22) // 캡슐의 크기 설정
                    .padding() // 캡슐 주위에 패딩을 추가
                    .overlay(
                        // 페이지 수 계산 및 텍스트로 표시
                        Text("\(pageIndex+1) / \(pageTotal)") // 현재 페이지 인덱스와 총 페이지 수를 표시
                            .foregroundColor(.white) // 텍스트 색상 설정
                            .font(.caption) // 텍스트 폰트 크기 설정
                    )
            }
        }
    }
}


#Preview {
    ADBannerItemView(pageIndex: .constant(2), pageTotal: .constant(3))
}
