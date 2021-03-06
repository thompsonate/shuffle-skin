//
//  ShapeButtonStyle.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/15/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI


struct ShapeButtonStyle<Content: Shape>: ButtonStyle {
    let shape: Content
    let color: Color
    let mouseDownColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                shape
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(color)
            )
            .overlay(
                    shape
                        .fill(mouseDownColor)
                        .opacity(configuration.isPressed ? 1 : 0)
                        .animation(.linear(duration: 0.1))
            )
    }
}
