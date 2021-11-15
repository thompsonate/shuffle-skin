//
//  RingStyle.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/21/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct RingColorScheme {
    let ringStroke: Color
    /// Ring button icons
    let ringIconBackground: Color
    let ringIconStroke: Color
    /// Angular gradient overlaid on mouse down
    let ringButtonMouseDown: Color
}


enum RingStyle {
    case light
    case dark
    
    var colorScheme: RingColorScheme {
        switch self {
        case .dark:
            return RingColorScheme(
                ringStroke: Color.black,
                ringIconBackground: Color.white,
                ringIconStroke: Color.black,
                ringButtonMouseDown: Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.5))
        case .light:
            return RingColorScheme(
                ringStroke: Color(red: 0.5, green: 0.5, blue: 0.5),
                ringIconBackground: Color(red: 0.55, green: 0.58, blue: 0.60),
                ringIconStroke: Color.white,
                ringButtonMouseDown: Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.3))
        }
    }

    var gradient: Gradient {
        switch self {
        case .dark:
            return Gradient(
                stops: [
                    .init(color: Color(red: 0.45, green: 0.45, blue: 0.45), location: 0),
                    .init(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.4),
                    .init(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.5),
                    .init(color: Color(red: 0.45, green: 0.45, blue: 0.45), location: 1)
                ]
            )

        case .light:
            return Gradient(
                stops: [
                    .init(color: Color(red: 0.81, green: 0.82, blue: 0.83), location: 0),
                    .init(color: Color(red: 0.98, green: 0.99, blue: 1), location: 0.35),
                    .init(color: Color(red: 0.98, green: 0.99, blue: 1), location: 0.55),
                    .init(color: Color(red: 0.81, green: 0.82, blue: 0.83), location: 1)
                ]
            )
        }
    }
    
    var gradientCenter: UnitPoint {
        switch self {
        case .dark:
            return .init(x: 0.51, y: 0.55)
        case .light:
            return .init(x: 0.51, y: 0.45)
        }
    }
}
