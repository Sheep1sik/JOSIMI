//
//  DraggableButton.swift
//  Josimi
//
//  Created by 양원식 on 9/12/24.
//

import SwiftUI

struct DraggableButton: View {
    
    @State private var dragAmount: CGPoint?
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    CameraButtonView()
                        .position(dragAmount ?? CGPoint(x: geometry.size.width-80, y: geometry.size.height-60))
                        .gesture(
                            DragGesture()
                                .onChanged { self.dragAmount = $0.location }
                                .onEnded { value in
                                    var currentPosition = value.location
                                    
                                    if currentPosition.x < (geometry.size.width/2)  {
                                        currentPosition.x = 25
                                    } else {
                                        currentPosition.x = geometry.size.width - 80
                                    }
                                    
                                    if currentPosition.y < 30 {
                                        currentPosition.y = 30
                                    }
                                    if currentPosition.y > geometry.size.height-60 {
                                        currentPosition.y = geometry.size.height - 60
                                    }
                                    
                                    dragAmount = currentPosition
                                }
                        )
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    DraggableButton()
}
