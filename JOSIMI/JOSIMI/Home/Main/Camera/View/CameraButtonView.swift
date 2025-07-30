//
//  CameraButtonView.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

struct CameraButtonView: View {
    @State private var isPressed = false
    @State private var opacityState: Double = 1.0

    var body: some View {
            VStack {
                Button {
                    
                } label: {
                    Circle()
                        .frame(width: 80, height: 80)
                        .shadow(radius: 1)
                        .overlay {
                            Image("scan")
                        }
                }
                .disabled(true)
                .opacity(opacityState)
                .onLongPressGesture(minimumDuration: 0.2) {
                    print("press")
                    withAnimation(.linear(duration: 0.1)) {
                        opacityState = 0.2
                    }
                    
                    withAnimation(.linear(duration: 0.1).delay(0.1)) {
                        opacityState = 1
                    }
                    isPressed = true
                }
                
            }
            .navigationDestination(isPresented: $isPressed) {
                ProductScannerView()
                    .navigationBarBackButtonHidden(true)
            }
    }
}

#Preview {
    CameraButtonView()
}
