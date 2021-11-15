//
//  AccessoryButton.swift
//  Shuffle
//
//  Created by Nate Thompson on 7/15/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct AccessoryButton: View {
    @EnvironmentObject var shuffle: ShuffleManager
    
    var icon: NSImage
    var mouseDownAction: (() -> Void)? = nil
    var mouseUpAction: (() -> Void)? = nil
    
    private var mouseDownIsBlocking = false
    
    @State var isPressed = false
    @State var isHovering = false
    
    /// - Parameters:
    ///   - icon: The icon to display inside the button.
    ///   - mouseDownAction: An action to trigger on mouse down.
    ///   - mouseUpAction: An action to trigger on mouse up.
    init(
        icon: NSImage,
        mouseDownAction: (() -> Void)? = nil,
        mouseUpAction: (() -> Void)? = nil)
    {
        self.icon = icon
        self.mouseDownAction = mouseDownAction
        self.mouseUpAction = mouseUpAction
    }
    
    /// - Parameters:
    ///   - icon: The icon to display inside the button.
    ///   - mouseDownAction: An action to trigger on mouse down.
    ///   - isBlocking: If mouseDownAction blocks the main thread.
    ///   This is useful for displaying an NSMenu, which only returns when the menu is dismissed.
    init(
        icon: NSImage,
        mouseDownAction: (() -> Void)?,
        isBlocking: Bool)
    {
        self.icon = icon
        self.mouseDownAction = mouseDownAction
        self.mouseDownIsBlocking = isBlocking
    }
    
    var body: some View {
        ZStack {
            Image(nsImage:
                icon.tinted(withColor:
                    self.shuffle.color.colorScheme.buttonIconBackground))
                .padding(3)
                .opacity(shuffle.windowIsKey || isHovering ? 1 : 0.5)
                .animation(.none)
            
            TransparentButton(
                acceptsFirstMouse: true,
                mouseDownAction: mouseDownAction,
                isBlocking: mouseDownIsBlocking,
                mouseUpAction: mouseUpAction,
                onPress: { isPressed in
                    self.isPressed = isPressed
            }, onHover: { isHovering in
                self.isHovering  = isHovering
            })
            
            Rectangle()
                .fill(self.shuffle.color.colorScheme.buttonMouseDown)
                .cornerRadius(3)
                .opacity(self.isPressed ? 1 : 0)
                .animation(.none)
        }
    }
}
