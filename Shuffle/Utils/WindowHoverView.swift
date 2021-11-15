//
//  WindowHoverView.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/17/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

/// Controls the visibility of the window's traffic light and accessory buttons based on
/// the cursor's location inside or outside the window.
struct WindowHoverView: NSViewRepresentable {
    typealias NSViewType = SHWindowHoverView
    
    func makeNSView(context: Context) -> NSViewType {
        return SHWindowHoverView()
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) { }
}

class SHWindowHoverView: NSView {
    private var trackingArea: NSTrackingArea?
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let trackingArea = self.trackingArea {
            self.removeTrackingArea(trackingArea)
        }

        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
        let newTrackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(newTrackingArea)
        
        self.trackingArea = newTrackingArea
    }
    
    
    override func mouseEntered(with event: NSEvent) {
        ShuffleManager.shared.isHoveringWindow = true
    }
    
    override func mouseExited(with event: NSEvent) {
        ShuffleManager.shared.isHoveringWindow = false
    }
}
