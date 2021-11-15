//
//  ColorScheme.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/21/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct ColorScheme {
    /// Horizontal background gradient
    let backgroundMain: Color
    let backgroundBright: Color
    let backgroundDark: Color
    let backgroundEdge: Color
    /// Vertical alpha gradient overlaid onto background gradient
    let backgroundOverlay: Color
    
    /// Play / pause button
    let playPauseIconBackground: Color
    let playPauseIconStroke: Color
    
    /// Accessory buttons
    let buttonIconBackground: NSColor
    
    /// Play / pause and accessory buttons
    let buttonMouseDown: Color
}

enum DeviceColor: Int, CaseIterable {
    case silver = 0
    case spaceGray = 6
    case blue = 1
    case green = 2
    case orange = 3
    case pink = 4
    case red = 5
    
    var name: String {
        switch self {
        case .silver:
            return "Silver"
        case .spaceGray:
            return "Space Gray"
        case .blue:
            return "Blue"
        case .green:
            return "Green"
        case .orange:
            return "Orange"
        case .pink:
            return "Pink"
        case .red:
            return "Red"
        }
    }
    
    var colorScheme: ColorScheme {
        switch self {
        case .silver:
            return ColorScheme(
                backgroundMain: Color(red: 0.8, green: 0.8, blue: 0.8),
                backgroundBright: Color(red: 0.94, green: 0.94, blue: 0.94),
                backgroundDark: Color(red: 0.77, green: 0.77, blue: 0.77),
                backgroundEdge: Color(red: 0.3, green: 0.3, blue: 0.3),
                backgroundOverlay: Color(red: 1, green: 1, blue: 1, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.31, green: 0.31, blue: 0.31),
                playPauseIconStroke: Color.white,
                
                buttonIconBackground: NSColor.black.withAlphaComponent(0.7),
                buttonMouseDown: Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5))
            
        case .spaceGray:
            return ColorScheme(
                backgroundMain: Color(red: 0.38, green: 0.38, blue: 0.38),
                backgroundBright: Color(red: 0.56, green: 0.56, blue: 0.56),
                backgroundDark: Color(red: 0.33, green: 0.33, blue: 0.33),
                backgroundEdge: Color(red: 0.16, green: 0.16, blue: 0.16),
                backgroundOverlay: Color(red: 0.53, green: 0.53, blue: 0.53, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.21, green: 0.21, blue: 0.21),
                playPauseIconStroke: Color.gray,
                
                buttonIconBackground: NSColor.white.withAlphaComponent(0.7),
                buttonMouseDown: Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 0.3))
            
        case .blue:
            return ColorScheme(
                backgroundMain: Color(red: 0.3, green: 0.51, blue: 0.69),
                backgroundBright: Color(red: 0.53, green: 0.71, blue: 0.86),
                backgroundDark: Color(red: 0.30, green: 0.49, blue: 0.67),
                backgroundEdge: Color(red: 0.24, green: 0.4, blue: 0.58),
                backgroundOverlay: Color(red: 0.56, green: 0.74, blue: 0.90, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.92, green: 0.93, blue: 0.93),
                playPauseIconStroke: Color.white,
                
                buttonIconBackground: NSColor.white.withAlphaComponent(0.7),
                buttonMouseDown:  Color(red: 0.24, green: 0.4, blue: 0.58, opacity: 0.3))
            
        case .green:
            return ColorScheme(
                backgroundMain: Color(red: 0.5, green: 0.65, blue: 0.25),
                backgroundBright: Color(red: 0.72, green: 0.88, blue: 0.45),
                backgroundDark: Color(red: 0.5, green: 0.62, blue: 0.29),
                backgroundEdge: Color(red: 0.37, green: 0.49, blue: 0.18),
                backgroundOverlay: Color(red: 0.73, green: 0.94, blue: 0.35, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.93, green: 0.92, blue: 0.92),
                playPauseIconStroke: Color.white,
                
                buttonIconBackground: NSColor.white.withAlphaComponent(0.7),
                buttonMouseDown: Color(red: 0.3, green: 0.39, blue: 0.15, opacity: 0.3))
            
        case .orange:
            return ColorScheme(
                backgroundMain: Color(red: 0.68, green: 0.48, blue: 0.19),
                backgroundBright: Color(red: 0.84, green: 0.66, blue: 0.37),
                backgroundDark: Color(red: 0.61, green: 0.43, blue: 0.21),
                backgroundEdge: Color(red: 0.53, green: 0.36, blue: 0.15),
                backgroundOverlay: Color(red: 0.97, green: 0.77, blue: 0.41, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.93, green: 0.93, blue: 0.92),
                playPauseIconStroke: Color.white,
                
                buttonIconBackground: NSColor.white.withAlphaComponent(0.7),
                buttonMouseDown: Color(red: 0.53, green: 0.36, blue: 0.14, opacity: 0.3))
            
        case .pink:
            return ColorScheme(
                backgroundMain: Color(red: 0.74, green: 0.28, blue: 0.48),
                backgroundBright: Color(red: 0.91, green: 0.51, blue: 0.7),
                backgroundDark: Color(red: 0.67, green: 0.26, blue: 0.43),
                backgroundEdge: Color(red: 0.62, green: 0.22, blue: 0.36),
                backgroundOverlay: Color(red: 0.97, green: 0.56, blue: 0.75, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.93, green: 0.92, blue: 0.93),
                playPauseIconStroke: Color.white,
                
                buttonIconBackground: NSColor.white.withAlphaComponent(0.7),
                buttonMouseDown: Color(red: 0.62, green: 0.22, blue: 0.36, opacity: 0.3))
            
        case .red:
            return ColorScheme(
                backgroundMain: Color(red: 0.76, green: 0.15, blue: 0.15),
                backgroundBright: Color(red: 0.94, green: 0.36, blue: 0.36),
                backgroundDark: Color(red: 0.68, green: 0.15, blue: 0.15),
                backgroundEdge: Color(red: 0.33, green: 0.07, blue: 0.07),
                backgroundOverlay: Color(red: 0.96, green: 0.22, blue: 0.22, opacity: 0.5),
                
                playPauseIconBackground: Color(red: 0.84, green: 0.84, blue: 0.84),
                playPauseIconStroke: Color(red: 0.92, green: 0.92, blue: 0.92),
                
                buttonIconBackground: NSColor.white.withAlphaComponent(0.7),
                buttonMouseDown: Color(red: 0.54, green: 0.13, blue: 0.13, opacity: 0.3))
        }
    }
    
    var ringStyle: RingStyle {
        switch self {
        case .silver, .spaceGray:
            return .dark
        case .blue, .green, .orange, .pink, .red:
            return .light
        }
    }
    
    var trafficLightAppearance: NSAppearance.Name {
        switch self {
        case .silver, .blue, .green, .orange, .pink, .red:
            return .aqua
        case .spaceGray:
            return .darkAqua
        }
    }
    
    var image: NSImage {
        switch self {
        case .silver:
            return NSImage(imageLiteralResourceName: "silver")
        case .spaceGray:
            return NSImage(imageLiteralResourceName: "space-gray")
        case .blue:
            return NSImage(imageLiteralResourceName: "blue")
        case .green:
            return NSImage(imageLiteralResourceName: "green")
        case .orange:
            return NSImage(imageLiteralResourceName: "orange")
        case .pink:
            return NSImage(imageLiteralResourceName: "pink")
        case .red:
            return NSImage(imageLiteralResourceName: "red")
        }
    }
}


struct ColorScheme_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ShuffleManager.shared)
            .previewLayout(.fixed(width: 500, height: 460))
    }
}
