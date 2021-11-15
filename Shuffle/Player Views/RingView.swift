//
//  RingView.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/12/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct RingView: View {
    @EnvironmentObject var shuffle: ShuffleManager

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(RadialGradient(
                        gradient: self.shuffle.color.ringStyle.gradient,
                        center: self.shuffle.color.ringStyle.gradientCenter,
                        startRadius: geometry.size.height * 0.225,
                        endRadius: geometry.size.height * 0.6))
                    .overlay(
                        Circle()
                            .stroke(self.shuffle.color.ringStyle.colorScheme.ringStroke,
                                    lineWidth: geometry.size.height * 0.002)
                    )
                
                
                PlusIcon()
                    .fill(self.shuffle.color.ringStyle.colorScheme.ringIconBackground)
                    .overlay(
                        PlusIcon()
                            .stroke(self.shuffle.color.ringStyle.colorScheme.ringIconStroke,
                                    lineWidth: geometry.size.height * 0.002)
                    )
                    .accessibility(addTraits: .isButton)
                    .accessibility(label: Text("Volume up"))
                    .accessibilityAction {
                        print("volume up")
                    }
                    .frame(width: geometry.size.height * 0.08,
                      height: geometry.size.height * 0.08)
                    .offset(x: 0, y: geometry.size.height * -0.4)
                
                
                MinusIcon()
                    .fill(self.shuffle.color.ringStyle.colorScheme.ringIconBackground)
                    .overlay(
                        MinusIcon()
                            .stroke(self.shuffle.color.ringStyle.colorScheme.ringIconStroke,
                                    lineWidth: geometry.size.height * 0.002)
                    )
                    .accessibility(addTraits: .isButton)
                    .accessibility(label: Text("Volume down"))
                    .accessibilityAction {
                        print("volume down")
                    }
                    .frame(width: geometry.size.height * 0.08,
                           height: geometry.size.height * 0.08)
                    .offset(x: 0, y: geometry.size.height * 0.4)
                
                
                TrackSkipIcon(direction: .next)
                    .fill(self.shuffle.color.ringStyle.colorScheme.ringIconBackground)
                    .overlay(
                        TrackSkipIcon(direction: .next)
                            .stroke(self.shuffle.color.ringStyle.colorScheme.ringIconStroke,
                                    lineWidth: geometry.size.height * 0.002)
                    )                    .accessibility(addTraits: .isButton)
                    .accessibility(label: Text("Next track"))
                    .accessibilityAction {
                        print("next track")
                    }
                    .aspectRatio(2, contentMode: .fit)
                    .frame(width: geometry.size.height * 0.11,
                           height: geometry.size.height * 0.11)
                    .offset(x: geometry.size.height * 0.4, y: 0)
                
                
                TrackSkipIcon(direction: .previous)
                    .fill(self.shuffle.color.ringStyle.colorScheme.ringIconBackground)
                    .overlay(
                        TrackSkipIcon(direction: .previous)
                            .stroke(self.shuffle.color.ringStyle.colorScheme.ringIconStroke,
                                    lineWidth: geometry.size.height * 0.002)
                    )
                    .accessibility(addTraits: .isButton)
                    .accessibility(label: Text("Previous track"))
                    .accessibilityAction {
                        print("previous track")
                    }
                    .aspectRatio(2, contentMode: .fit)
                    .frame(width: geometry.size.height * 0.11,
                           height: geometry.size.height * 0.11)
                    .offset(x: geometry.size.height * -0.4, y: 0)
                
                RingButtonsView()
                    .environmentObject(self.shuffle)
            }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ZStack {
                RingView()
                    .environmentObject(ShuffleManager.shared)
                PlayPauseButtonView()
                    .environmentObject(ShuffleManager.shared)
                    .opacity(0.5)
                    .frame(width: geometry.size.height * 0.593,
                           height: geometry.size.height * 0.593,
                           alignment: .center)
            }
        }
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
