//
//  ActivityIndicator.swift
//  Shuffle
//
//  Created by Nate Thompson on 3/29/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: View {
    @EnvironmentObject var shuffle: ShuffleManager
    @Binding var isVisible: Bool
    
    var body: some View {
        let appearance = Binding<NSAppearance.Name>(get: {
            switch self.shuffle.color {
            case .silver:
                return .aqua
            case .spaceGray, .blue, .green, .orange, .pink, .red:
                return .darkAqua
            }
        }, set: { _ in })
        
        return ActivityIndicatorView(isVisible: $isVisible, appearance: appearance)
            .opacity(self.isVisible ? 1 : 0)
            .animation(.linear(duration: 0.2))
            .accessibility(hidden: true)
    }
}

struct ActivityIndicatorView: NSViewRepresentable {
    typealias NSViewType = NSProgressIndicator
    
    @Binding var isVisible: Bool
    @Binding var appearance: NSAppearance.Name
    
    func makeNSView(context: NSViewRepresentableContext<ActivityIndicatorView>) -> NSProgressIndicator {
        let progress = NSProgressIndicator()
        progress.isIndeterminate = true
        progress.style = .spinning
        progress.controlSize = .mini
        
        return progress
    }
    
    func updateNSView(_ nsView: NSProgressIndicator, context: NSViewRepresentableContext<ActivityIndicatorView>) {
        nsView.appearance = NSAppearance(named: appearance)
        
        if isVisible {
            nsView.startAnimation(self)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nsView.stopAnimation(self)
            }
        }
    }
}
