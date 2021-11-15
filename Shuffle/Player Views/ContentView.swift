//
//  ContentView.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/12/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var shuffle: ShuffleManager
    
    private let titleBarHeight: CGFloat = 22.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WindowHoverView()
                
                BackgroundView()
                    .mouseDownCanMoveWindow()
                    .environmentObject(self.shuffle)
                
                RingView()
                    .frame(width: geometry.size.height * 0.86,
                           height: geometry.size.height * 0.86,
                           alignment: .center)
                    .environmentObject(self.shuffle)
                
                PlayPauseButtonView()
                    .frame(width: geometry.size.height * 0.51,
                           height: geometry.size.height * 0.51,
                           alignment: .center)
                    .environmentObject(self.shuffle)
            }
            .overlay(
                ActivityIndicator(isVisible: self.$shuffle.showActivityIndicator)
                    .padding(6),
                alignment: .topTrailing)
            .overlay(
                ContextMenuButton().environmentObject(self.shuffle)
                    .frame(width: 20, height: 20)
                    .padding(5),
                alignment: .bottomTrailing)
        }
        .edgesIgnoringSafeArea([.all])
        .frame(minWidth: 150, maxWidth: 500, minHeight: 138 - titleBarHeight)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ShuffleManager.shared)
            .previewLayout(.fixed(width: 150, height: 138))
    }
}

