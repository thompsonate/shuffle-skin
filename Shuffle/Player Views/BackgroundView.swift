//
//  BackgroundView.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/13/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var shuffle: ShuffleManager
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: self.shuffle.color.colorScheme.backgroundEdge, location: 0),
                        .init(color: self.shuffle.color.colorScheme.backgroundBright, location: 0.02),
                        .init(color: self.shuffle.color.colorScheme.backgroundMain, location: 0.08),
                        .init(color: self.shuffle.color.colorScheme.backgroundMain, location: 0.93),
                        .init(color: self.shuffle.color.colorScheme.backgroundDark, location: 0.95),
                        .init(color: self.shuffle.color.colorScheme.backgroundBright, location: 0.982),
                        .init(color: self.shuffle.color.colorScheme.backgroundEdge, location: 1)
                    ]
                ),
                startPoint: .leading,
                endPoint: .trailing))
            .overlay(Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(
                        colors: [
                            self.shuffle.color.colorScheme.backgroundOverlay,
                            self.shuffle.color.colorScheme.backgroundOverlay.opacity(0)
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom))
            )
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .environmentObject(ShuffleManager.shared)
            .previewLayout(.fixed(width: 500, height: 460))
    }
}
