//
//  AppDelegate.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/12/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine
import MusicKitPlayer

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var window: NSWindow!
    
    private var subscribers = Set<AnyCancellable>()

    @IBOutlet weak var menuController: MenuController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environmentObject(ShuffleManager.shared)

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.delegate = self
        window.isReleasedWhenClosed = false
        window.collectionBehavior = [.fullScreenNone, .fullScreenDisallowsTiling]
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
        
        window.standardWindowButton(.closeButton)?.wantsLayer = true
        window.standardWindowButton(.miniaturizeButton)?.wantsLayer = true
        
        window.aspectRatio = NSSize(width: 112, height: 103)
        window.contentView = NSHostingView(rootView: contentView)
        
        MusicKitPlayer.shared.addEventListener(for: .musicKitDidLoad) {
            self.showWindow()
        }
        
        subscribeToPublishers()
        
        MusicKitPlayer.shared.enhancedErrorLogging = true
    }
    
    private func showWindow() {
        window.makeKeyAndOrderFront(nil)
        ShuffleManager.shared.windowDidShow()
    }
    
    
    private func subscribeToPublishers() {
        // Set traffic light button appearance based on background color
        ShuffleManager.shared.$color.sink {
            self.setTrafficLightButtonAppearance($0.trafficLightAppearance)
        }.store(in: &subscribers)
        
        // Hide traffic light buttons when cursor is outside of window
        ShuffleManager.shared.$showAccessoryButtons.sink {
            let visibility: ButtonVisibility = $0 ? .visible : .hidden
            self.setTrafficLightButtonVisibility(visibility)
        }.store(in: &subscribers)
        
        ShuffleManager.shared.$floatWindow.sink {
            let level: NSWindow.Level = $0 ? .floating : .normal
            self.window.level = level
        }.store(in: &subscribers)
    }
    
    
    func applicationShouldHandleReopen(
        _ sender: NSApplication,
        hasVisibleWindows flag: Bool) -> Bool
    {
        if flag {
            return false
        } else {
            window.makeKeyAndOrderFront(nil)
            return true
        }
    }

    
    func setTrafficLightButtonVisibility(_ visibility: ButtonVisibility) {
        guard let closeButton = window.standardWindowButton(.closeButton),
            let miniaturizeButton = window.standardWindowButton(.miniaturizeButton)
        else { return }

        switch visibility {
        case .visible:
            closeButton.alphaValue = 0
            miniaturizeButton.alphaValue = 0
            closeButton.isHidden = false
            miniaturizeButton.isHidden = false
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = ShuffleManager.shared.buttonAnimationDuration
                closeButton.animator().alphaValue = 1
                miniaturizeButton.animator().alphaValue = 1
            }
            
        case .hidden:
            NSAnimationContext.runAnimationGroup { context in
                context.duration = ShuffleManager.shared.buttonAnimationDuration
                closeButton.animator().alphaValue = 0
                miniaturizeButton.animator().alphaValue = 0
            }
        }
    }
    
    
    enum ButtonVisibility {
        case visible
        case hidden
    }
    
    
    func setTrafficLightButtonAppearance(_ appearanceName: NSAppearance.Name) {
        guard let appearance = NSAppearance(named: appearanceName),
              let closeButton = window.standardWindowButton(.closeButton),
              let miniaturizeButton = window.standardWindowButton(.miniaturizeButton)
        else { return }
        
        closeButton.appearance = appearance
        miniaturizeButton.appearance = appearance
    }
    
    func windowDidBecomeKey(_ notification: Notification) {
        ShuffleManager.shared.windowIsKey = true
    }
    
    func windowDidResignKey(_ notification: Notification) {
        ShuffleManager.shared.windowIsKey = false
    }
}

