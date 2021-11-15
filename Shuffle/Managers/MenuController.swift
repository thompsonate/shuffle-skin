//
//  MenuController.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/22/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import Cocoa
import MusicKitPlayer
import SwiftUI
import Combine

class MenuController: NSObject, NSMenuDelegate {
    var aboutWindow: NSWindow!
    var prefsWindow: NSWindow!
    
    // MARK: Main Menu
    @IBOutlet weak var colorsMenu: NSMenu!
    
    @IBOutlet weak var voiceOverMenuItem: NSMenuItem!
    @IBOutlet weak var floatOnTopMenuItem: NSMenuItem!
    
    // MARK: Context Menu
    @IBOutlet weak var contextMenu: NSMenu!
    @IBOutlet weak var colorsContextSubmenu: NSMenu!
    @IBOutlet weak var repeatContextSubmenu: NSMenu!
    
    @IBOutlet weak var shuffleContextMenuItem: NSMenuItem!
    @IBOutlet weak var voiceOverContextMenuItem: NSMenuItem!
    @IBOutlet weak var signInContextMenuItem: NSMenuItem!
    @IBOutlet weak var signOutContextMenuItem: NSMenuItem!
    @IBOutlet weak var floatOnTopContextMenuItem: NSMenuItem!
    
    private let deviceColors = DeviceColor.allCases
    private let colorIdPrefix = "color"
    private let repeatIdPrefix = "repeatMode"
    
    private var subscribers = Set<AnyCancellable>()
    
    private var appDelegate: AppDelegate {
        NSApp.delegate as! AppDelegate
    }
    
    override func awakeFromNib() {
        ShuffleManager.shared.$floatWindow.sink {
            let state: NSControl.StateValue = $0 ? .on : .off
            self.floatOnTopMenuItem.state = state
            self.floatOnTopContextMenuItem.state = state
        }.store(in: &subscribers)
    }
    
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        guard let identifier = menu.identifier else { return }
        switch identifier {
        case .colorsMenu:
            colorsMenu.items = colorsMenuItems
        case .colorsContextSubmenu:
            colorsContextSubmenu.items = colorsMenuItems
        default:
            break
        }
    }
    
    /// This function is blocking until the menu is dismissed.
    func showContextMenu(at point: CGPoint) {
        guard let contentView = appDelegate.window.contentView,
            let menu = appDelegate.menuController.contextMenu else { return }
        
        let pointLowered = CGPoint(x: point.x, y: point.y + 30)
        menu.popUp(positioning: nil, at: pointLowered, in: contentView)
    }
    
    var colorsMenuItems: [NSMenuItem] {
        var menuItems = [NSMenuItem]()
        
        for color in deviceColors {
            let item = NSMenuItem()
            
            item.title = color.name
            item.identifier = NSUserInterfaceItemIdentifier("\(colorIdPrefix)\(color.rawValue)")
            item.image = color.image

            item.target = self
            item.action = #selector(colorMenuItemClicked(_:))
            
            if color == ShuffleManager.shared.color {
                item.state = .on
            } else {
                item.state = .off
            }
            
            menuItems.append(item)
        }
        return menuItems
    }
    
    
    // MARK: Selectors and Actions
    @IBAction func showAboutWindow(_ sender: Any) {
        if aboutWindow == nil {
            aboutWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false)
            aboutWindow.center()
            aboutWindow.setFrameAutosaveName("About Window")
            aboutWindow.contentView = NSHostingView(rootView: AboutWindowView())
            aboutWindow.isReleasedWhenClosed = false
        }
        aboutWindow.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func sendFeedback(_ sender: Any) {
        let mailtoLink = "mailto:nate@natethompson.io?subject=shuffl%20Feedback"
        NSWorkspace.shared.open(URL(string: mailtoLink)!)
    }
    
    @objc func colorMenuItemClicked(_ sender: NSMenuItem) {
        guard let identifier = sender.identifier?.rawValue.dropFirst(colorIdPrefix.count),
            let colorNumber = Int(identifier),
            let color = DeviceColor(rawValue: colorNumber) else { return }
        
        ShuffleManager.shared.color = color
    }
    
    @IBAction func toggleFloatOnTop(_ sender: Any) {
        ShuffleManager.shared.floatWindow.toggle()
    }
}


extension NSUserInterfaceItemIdentifier {
    static let colorsMenu = NSUserInterfaceItemIdentifier("colorsMenu")
    static let colorsContextSubmenu = NSUserInterfaceItemIdentifier("colorsContextSubmenu")
    static let controlsMenu = NSUserInterfaceItemIdentifier("controlsMenu")
}
