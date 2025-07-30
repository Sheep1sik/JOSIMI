//
//  RoundedCorners.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

// 특정 모서리만 둥글게 하기 위한 커스텀 ViewModifier
struct RoundedCorners: Shape {
    var radius: CGFloat = 25.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
