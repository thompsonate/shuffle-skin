//
//  RingButton.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/16/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct RingButton: View {
    @EnvironmentObject var shuffle: ShuffleManager
    @State private var showButtonPressEffect = false

    let startAngle: Angle
    let endAngle: Angle
    let action: () -> Void
    
    var body: some View {
        TransparentButton(
            mouseUpAction: action,
            onPress: { isPressed in
                self.showButtonPressEffect = isPressed
        })
            .contentShape(Wedge(startAngle: startAngle, endAngle: endAngle))
            .overlay(
                RingMouseDownOverlayView(
                    buttonStartAngle: startAngle,
                    buttonEndAngle: endAngle,
                    isVisible: $showButtonPressEffect)
                    .environmentObject(self.shuffle))
    }
}


fileprivate struct RingMouseDownOverlayView: View {
    let startAngle: Angle
    let endAngle: Angle
    
    @EnvironmentObject var shuffle: ShuffleManager
    @Binding var isVisible: Bool
    
    private var gradientCrosses2Pi = false
    
    init(buttonStartAngle: Angle, buttonEndAngle: Angle, isVisible: Binding<Bool>) {
        self._isVisible = isVisible
        
        if buttonStartAngle > buttonEndAngle {
            // special case where the non-transparent part of the gradient needs to cross 0º
            gradientCrosses2Pi = true
            self.startAngle = buttonEndAngle - .degrees(22.5)
            self.endAngle = buttonStartAngle + .degrees(22.5)
        } else {
            self.startAngle = buttonStartAngle - .degrees(22.5)
            self.endAngle = buttonEndAngle + .degrees(22.5)
        }
    }
    
    var gradient: Gradient {
        if gradientCrosses2Pi {
            return Gradient(stops: [
                .init(color: self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown,
                      location: 0),
                .init(color: self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown.opacity(0),
                      location: 0.125),
                .init(color: self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown.opacity(0),
                      location: 0.875),
                .init(color: self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown,
                      location: 1)
            ])
        } else {
            return Gradient(colors: [
                self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown.opacity(0),
                self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown,
                self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown,
                self.shuffle.color.ringStyle.colorScheme.ringButtonMouseDown.opacity(0)
            ])
        }
    }
    
    var body: some View {
        Circle()
            .fill(AngularGradient(
                gradient: gradient,
                center: .center,
                startAngle: startAngle,
                endAngle: endAngle))
            .opacity(self.isVisible ? 1 : 0)
            .animation(.linear(duration: 0.1))
    }
}


struct RingButton_Previews: PreviewProvider {
    static var previews: some View {
        RingButton(startAngle: .degrees(45), endAngle: .degrees(135), action: { })
            .environmentObject(ShuffleManager.shared)
    }
}
