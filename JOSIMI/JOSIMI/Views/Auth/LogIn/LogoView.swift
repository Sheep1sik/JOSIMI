//
//  LogoView.swift
//  JOSIMI
//
//  Created by 양원식 on 11/17/24.
//

import SwiftUI

// MARK: - 로고
struct LogoView: View {
    let size: CGFloat

    var body: some View {
        // 임시 로고
        Rectangle()
            .stroke()
            .frame(minWidth: 120, minHeight: 120)
            .frame(width: size, height: size)
            .foregroundColor(.red)
    }
}

#Preview {
    LogoView(size: 120)
}
