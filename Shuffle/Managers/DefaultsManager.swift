//
//  DefaultsManager.swift
//  Shuffle
//
//  Created by Nate Thompson on 3/29/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import Foundation
import MusicKitPlayer

class DefaultsManager {
    static var shared = DefaultsManager()
    
    private var defaults = UserDefaults.standard
    
    var color: DeviceColor {
        get {
            if let savedColor = defaults.value(forKey: DefaultsKey.color) as? Int,
                let deviceColor = DeviceColor(rawValue: savedColor)
            {
                return deviceColor
            } else {
                return .silver
            }
        }
        set {
            defaults.set(newValue.rawValue, forKey: DefaultsKey.color)
        }
    }
    
    var shuffleMode: PlayerShuffleMode {
        get {
            if let shuffleModeInt = defaults.value(forKey: DefaultsKey.shuffleMode) as? Int,
               let shuffleMode = PlayerShuffleMode(rawValue: shuffleModeInt)
            {
                return shuffleMode
            } else {
                return .shuffle
            }
        }
        set {
            let shuffleModeInt = newValue.rawValue
            defaults.set(shuffleModeInt, forKey: DefaultsKey.shuffleMode)
        }
    }
    
    var repeatMode: PlayerRepeatMode {
        get {
            if let repeatModeInt = defaults.value(forKey: DefaultsKey.repeatMode) as? Int,
                let repeatMode = PlayerRepeatMode(rawValue: repeatModeInt)
            {
                return repeatMode
            } else {
                return .all
            }
        }
        set {
            let repeatModeInt = newValue.rawValue
            defaults.set(repeatModeInt, forKey: DefaultsKey.repeatMode)
        }
    }
    
    var floatWindow: Bool {
        get {
            return defaults.bool(forKey: DefaultsKey.floatWindow)
        }
        set {
            defaults.set(newValue, forKey: DefaultsKey.floatWindow)
        }
    }
    
    var isFirstLaunch: Bool {
        get {
            if let value = defaults.value(forKey: DefaultsKey.isFirstLaunch) as? Bool {
                return value
            } else {
                return true
            }
        }
        set {
            defaults.set(newValue, forKey: DefaultsKey.isFirstLaunch)
        }
    }
}

enum DefaultsKey {
    static let color = "color"
    static let source = "source"
    static let shuffleMode = "shuffleMode"
    static let repeatMode = "repeatMode"
    static let floatWindow = "floatWindow"
    static let isFirstLaunch = "isFirstLaunch"
}
