//
//  ADBannerView.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

// ADBannerView 구조체

// ADBannerView는 광고 배너를 무한 스크롤로 보여주는 뷰입니다.
struct ADBannerView: View {
    // ADBannerViewModel 인스턴스를 상태 객체로 선언하여 뷰 모델을 관리합니다.
    @StateObject private var viewModel = ADBannerViewModel()
    
    var body: some View {
        // InfinitePageView를 사용하여 광고 이미지를 무한 스크롤로 보여줍니다.
        InfinitePageView(
            // 현재 선택된 광고 인덱스를 바인딩합니다.
            selection: $viewModel.adIndex,
            // 이전 광고 인덱스를 계산하는 클로저입니다.
            before: { viewModel.correctedIndex(for: $0 - 1) },
            // 다음 광고 인덱스를 계산하는 클로저입니다.
            after: { viewModel.correctedIndex(for: $0 + 1) },
            // 주어진 인덱스에 해당하는 광고 이미지를 보여주는 뷰를 생성하는 클로저입니다.
            view: { index in
                ZStack {
                    withAnimation {
                        // 인덱스에 해당하는 광고 이미지를 표시합니다.
                        Image(viewModel.adImages[index])
                            .resizable()
                    }
                    // 광고 배너 항목 뷰를 추가하여 현재 페이지 인덱스와 총 페이지 수를 표시합니다.
                    ADBannerItemView(pageIndex: $viewModel.adIndex, pageTotal: .constant(viewModel.adImages.count))
                }
            }
        )
        // 광고 배너 뷰의 높이를 200으로 설정합니다.
        .frame(height: 200)
        // 뷰가 나타날 때 자동 스크롤을 시작합니다.
        .onAppear {
            viewModel.startAutoScroll()
        }
        // 뷰가 사라질 때 자동 스크롤을 중지합니다.
        .onDisappear {
            viewModel.stopAutoScroll()
        }
    }
}

#Preview {
    ADBannerView()
}
