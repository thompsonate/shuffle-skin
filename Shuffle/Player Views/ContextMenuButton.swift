//
//  ContextMenuButton.swift
//  Shuffle
//
//  Created by Nate Thompson on 7/9/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct ContextMenuButton: View {
    @EnvironmentObject var shuffle: ShuffleManager
    
    var body: some View {
        GeometryReader { geometry in
            AccessoryButton(
                icon: #imageLiteral(resourceName: "settings-icon"),
                mouseDownAction: {
                var point = geometry.frame(in: .global).origin
                // Move the menu down by 6 pixels to create a gap
                point.y -= 6
                
                self.shuffle.menuController.showContextMenu(at: point)
            }, isBlocking: true)
                .opacity(self.shuffle.showAccessoryButtons ? 1 : 0)
                .animation(.linear(duration: self.shuffle.buttonAnimationDuration))
                .accessibility(addTraits: .isButton)
                .accessibility(label: Text("Settings menu"))
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuButton()
    }
}
