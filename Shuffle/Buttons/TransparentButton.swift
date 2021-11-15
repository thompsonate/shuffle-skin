//
//  TransparentButton.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/15/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct TransparentButton: NSViewRepresentable {
    typealias NSViewType = MouseEventView

    let acceptsFirstMouse: Bool
    let mouseDownAction: (() -> Void)?
    let mouseDownIsBlocking: Bool
    let mouseUpAction: (() -> Void)?
    let onPress: ((Bool) -> Void)?
    let onHover: ((Bool) -> Void)?
    
    init(
        acceptsFirstMouse: Bool = false,
        mouseDownAction: (() -> Void)? = nil,
        isBlocking: Bool = false,
        mouseUpAction: (() -> Void)? = nil,
        onPress: ((Bool) -> Void)? = nil,
        onHover: ((Bool) -> Void)? = nil)
    {
        self.acceptsFirstMouse = acceptsFirstMouse
        self.mouseDownAction = mouseDownAction
        self.mouseDownIsBlocking = isBlocking
        self.mouseUpAction = mouseUpAction
        self.onPress = onPress
        self.onHover = onHover
    }
        
    func makeNSView(context: Context) -> NSViewType {
        return MouseEventView(
            acceptsFirstMouse: acceptsFirstMouse,
            mouseDownAction: mouseDownAction,
            isBlocking: mouseDownIsBlocking,
           mouseUpAction: mouseUpAction,
           onPress: onPress,
           onHover: onHover)
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) { }
}


class MouseEventView: NSView {
    let acceptsFirstMouse: Bool
    let mouseDownAction: (() -> Void)?
    let mouseDownIsBlocking: Bool
    let mouseUpAction: (() -> Void)?
    let onPress: ((Bool) -> Void)?
    let onHover: ((Bool) -> Void)?

    init(
        acceptsFirstMouse: Bool,
        mouseDownAction: (() -> Void)?,
        isBlocking: Bool,
        mouseUpAction: (() -> Void)?,
        onPress: ((Bool) -> Void)?,
        onHover: ((Bool) -> Void)?)
    {
        self.acceptsFirstMouse = acceptsFirstMouse
        self.mouseDownAction = mouseDownAction
        self.mouseDownIsBlocking = isBlocking
        self.mouseUpAction = mouseUpAction
        self.onPress = onPress
        self.onHover = onHover
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    /// Whether or not the button show show pressed state.
    /// Calls onPress when the value changes.
    private var isPressed = false {
        willSet {
            if newValue != isPressed {
                onPress?(newValue)
            }
        }
    }
    
    private var isMouseInside = false {
        willSet {
            if newValue != isMouseInside  {
                onHover?(newValue)
            }
        }
    }
        
    override func mouseDown(with event: NSEvent) {
        isPressed = true
        mouseDownAction?()
        
        // If mouseDownAction is blocking, we don't expect a mouseUpAction.
        // Return back to unpressed state here, after menu the action unblocks.
        if mouseDownIsBlocking {
            self.isPressed = false
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        isPressed = false
        
        if isMouseInside {
            mouseUpAction?()
        }
    }

    override func mouseDragged(with event: NSEvent) {
        // Only show pressed state when mouse down inside button.
        isPressed = isMouseInside
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return acceptsFirstMouse
    }
    
    override func mouseEntered(with event: NSEvent) {
        isMouseInside = true
    }
    
    override func mouseExited(with event: NSEvent) {
        isMouseInside = false
    }
    
    private var trackingArea: NSTrackingArea?
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let trackingArea = self.trackingArea {
            self.removeTrackingArea(trackingArea)
        }

        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .enabledDuringMouseDrag, .activeAlways]
        let newTrackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(newTrackingArea)
        
        self.trackingArea = newTrackingArea
    }
}
