//
//  MediaButtonStyle.swift
//  Shuffle
//
//  Created by Nate Thompson on 7/2/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct MediaButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .overlay(
                Rectangle()
                    .fill(Color.black)
                    .cornerRadius(cornerRadius)
                    .opacity(configuration.isPressed ? 0.2 : 0.0)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0,
                         anchor: .center)
            .animation(.easeInOut(duration: 0.1))
    }
}
