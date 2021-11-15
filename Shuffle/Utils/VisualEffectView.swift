//
//  VisualEffectView.swift
//  Shuffle
//
//  Created by Nate Thompson on 7/3/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct VisualEffectView: NSViewRepresentable {
    typealias NSViewType = NSVisualEffectView
    
    let blendingMode: NSVisualEffectView.BlendingMode
    let material: NSVisualEffectView.Material
    let cornerRadius: CGFloat
    
    func makeNSView(context: Context) -> NSViewType {
        let view = NSVisualEffectView()
        view.wantsLayer = true
        view.layer?.cornerRadius = cornerRadius
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        nsView.blendingMode = blendingMode
        nsView.material = material
    }
}
