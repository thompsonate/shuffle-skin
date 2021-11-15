//
//  PlayPauseButtonView.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/12/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct PlayPauseButtonView: View {
    @EnvironmentObject var shuffle: ShuffleManager
    @State var showButtonDownEffect = false
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                print("play/pause")
            }, label: {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    self.shuffle.color.colorScheme.backgroundOverlay,
                                    self.shuffle.color.colorScheme.backgroundMain
                            ]),
                            startPoint: .top,
                            endPoint: .bottom))
                        .overlay(
                            Circle()
                                .stroke(self.shuffle.color.ringStyle.colorScheme.ringStroke,
                                        lineWidth: geometry.size.height * 0.004)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    PlayIcon()
                        .fill(self.shuffle.color.colorScheme.playPauseIconBackground)
                        .overlay(
                            PlayIcon()
                                .stroke(self.shuffle.color.colorScheme.playPauseIconStroke,
                                        lineWidth: geometry.size.height * 0.004)
                        )
                        .frame(width: geometry.size.height * 0.13,
                               height: geometry.size.height * 0.13)
                        .offset(x: geometry.size.height * -0.07, y: 0)
                    
                    PauseIcon()
                        .fill(self.shuffle.color.colorScheme.playPauseIconBackground)
                        .overlay(
                            PauseIcon()
                                .stroke(self.shuffle.color.colorScheme.playPauseIconStroke,
                                        lineWidth: geometry.size.height * 0.004)
                        )
                        .frame(width: geometry.size.height * 0.13,
                               height: geometry.size.height * 0.13)
                        .offset(x: geometry.size.height * 0.1, y: 0)
                }
            })
                .buttonStyle(ShapeButtonStyle(
                    shape: Circle(),
                    color: self.shuffle.color.colorScheme.backgroundMain,
                    mouseDownColor: self.shuffle.color.colorScheme.buttonMouseDown))
                .accessibility(addTraits: [.playsSound, .updatesFrequently])
                .accessibility(label: Text(self.shuffle.isPlaying ? "Pause" : "Play"))
                .accessibility(hint: Text(self.shuffle.isPlaying ?
                    "Pauses the player" : "Plays the current track"))
        }
    }
}


struct PlayPauseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButtonView()
            .environmentObject(ShuffleManager.shared)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
