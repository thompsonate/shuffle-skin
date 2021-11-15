//
//  HorizontalScrollView.swift
//  Shuffle
//
//  Created by Nate Thompson on 7/8/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct HorizontalScrollView<Content>: NSViewRepresentable where Content : View {
    
    typealias NSViewType = CustomScrollView
    
    private var contentHostingView: NSHostingView<Content>
    
    init(label: () -> Content) {
        contentHostingView = NSHostingView(rootView: label())
    }
    
    func makeNSView(context: Context) -> CustomScrollView {
        let scrollView = CustomScrollView()
        scrollView.documentView = contentHostingView
        scrollView.hasHorizontalScroller = true
        scrollView.drawsBackground = false
        return scrollView
    }
    
    func updateNSView(_ nsView: CustomScrollView, context: Context) {
        contentHostingView.setFrameSize(contentHostingView.intrinsicContentSize)
        nsView.setIntrinsicHeight(contentHostingView.intrinsicContentSize.height)
    }
}


class CustomScrollView: NSScrollView {
    private var intrinsicHeight: CGFloat = 0
    
    func setIntrinsicHeight(_ height: CGFloat) {
        intrinsicHeight = height
    }
    
    override var intrinsicContentSize: NSSize {
        NSSize(width: 0, height: intrinsicHeight)
    }
    
    // Pass events to enclosing vertical ScrollView if scroll is vertical
    override func scrollWheel(with event: NSEvent) {
        if abs(event.scrollingDeltaX) < abs(event.scrollingDeltaY) {
            self.nextResponder?.scrollWheel(with: event)
        } else {
            super.scrollWheel(with: event)
        }
    }
}
