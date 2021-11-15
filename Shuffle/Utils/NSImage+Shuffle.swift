//
//  NSImage+Shuffle.swift
//  Shuffle
//
//  Created by Nate Thompson on 7/22/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import Cocoa

extension NSImage {
    // https://stackoverflow.com/a/44833596
    func tinted(withColor tintColor: NSColor) -> NSImage {
        guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return self }

        return NSImage(size: size, flipped: false) { bounds in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }

            tintColor.set()
            context.clip(to: bounds, mask: cgImage)
            context.fill(bounds)

            return true
        }
    }
}
