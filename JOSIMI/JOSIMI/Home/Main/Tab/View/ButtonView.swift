//
//  ButtonView.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

struct ButtonView: View {
    var imageName: String
        
        var body: some View {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
            }
        }
}

#Preview {
    ButtonView(imageName: "home")
}
