//
//  ShuffleManager.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/21/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import Cocoa
import MusicKitPlayer

class ShuffleManager: ObservableObject {
    static var shared = ShuffleManager()
    
    private var defaults = UserDefaults.standard
    
    private var voiceOverObservation: NSKeyValueObservation
    private var switchControlObservation: NSKeyValueObservation
    
    init() {
        color = DefaultsManager.shared.color
        floatWindow = DefaultsManager.shared.floatWindow
        
        isVoiceOverEnabled = NSWorkspace.shared.isVoiceOverEnabled
        voiceOverObservation = NSWorkspace.shared.observe(
            \.isVoiceOverEnabled,
            options: .new,
            changeHandler: { (_, change) in
                if let newValue = change.newValue {
                    ShuffleManager.shared.isVoiceOverEnabled = newValue
                }
        })
        
        isSwitchControlEnabled = NSWorkspace.shared.isSwitchControlEnabled
        switchControlObservation = NSWorkspace.shared.observe(
            \.isSwitchControlEnabled,
            options: .new,
            changeHandler: { (_, change) in
                if let newValue = change.newValue {
                    ShuffleManager.shared.isSwitchControlEnabled = newValue
                }
        })
        
        MusicKitPlayer.shared.addEventListener(for: .playbackStateDidChange) {
            MusicKitPlayer.shared.player.getPlaybackState { playbackState in
                switch playbackState {
                case .loading, .waiting, .seeking:
                    self.showActivityIndicator = true
                    self.isPlaying = true
                case .playing:
                    self.isPlaying = true
                    self.showActivityIndicator = false
                default:
                    self.showActivityIndicator = false
                    self.isPlaying = false
                }
            }
        }
    }
    
    func windowDidShow() {
        if DefaultsManager.shared.isFirstLaunch {
            DefaultsManager.shared.isFirstLaunch = false
        }
    }
        
    @Published var color: DeviceColor {
        didSet {
            DefaultsManager.shared.color = color
        }
    }
    
    /// The state of the music player
    @Published var isPlaying = false
    
    /// The visibility of the loading activity indicator.
    @Published var showActivityIndicator = false
    
    /// If the cursor is in the window.
    @Published var isHoveringWindow = false {
        didSet {
            updateShowAccessoryButtons()
        }
    }

    @Published private(set) var showAccessoryButtons = false
    
    private func updateShowAccessoryButtons() {
        showAccessoryButtons = isHoveringWindow || isVoiceOverEnabled || isSwitchControlEnabled
    }
    
    var buttonAnimationDuration: Double { 0.25 }
    
    /// The visibility of the source browser popover.
    @Published var showSourcePopover = false
    
    @Published var windowIsKey = false
    
    @Published var floatWindow = false {
        didSet {
            DefaultsManager.shared.floatWindow = floatWindow
        }
    }
    
    @Published var isVoiceOverEnabled = false {
        didSet {
            updateShowAccessoryButtons()
        }
    }
    
    @Published var isSwitchControlEnabled = false {
        didSet {
            updateShowAccessoryButtons()
        }
    }
    
    var appDelegate: AppDelegate {
        NSApp.delegate as! AppDelegate
    }
    
    var menuController: MenuController {
        appDelegate.menuController
    }
}
