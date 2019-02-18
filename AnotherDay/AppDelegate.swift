//
//  AppDelegate.swift
//  today
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var preferencesController: NSWindowController?
    var mainWindowController: NSWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Change application icon
        // NSApplication.shared.applicationIconImage
    }
    
    func applicationWillBecomeActive(_ notification: Notification) {
        Cycle.initCycleCheck()
        if Cycle.shouldDoCycle() {
            Cycle.doCycle()
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            if !(mainWindowController != nil) {
                mainWindowController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MainWindowController") as! TodayWindowController
                mainWindowController!.showWindow(sender)
            }
            
            if (mainWindowController != nil) {
                mainWindowController!.showWindow(sender)
            }
        }
        
        return true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func showMainWindow(_ sender: Any) {
        if !(mainWindowController != nil) {
            mainWindowController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MainWindowController") as! TodayWindowController
            mainWindowController!.showWindow(sender)
        }
        
        if (mainWindowController != nil) {
            mainWindowController!.showWindow(sender)
        }
    }
    
    @IBAction func showPreferences(_ sender: Any) {
        if !(preferencesController != nil) {
            preferencesController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "PreferencesController") as! PreferencesWindowController
            preferencesController!.showWindow(sender)
        }
        
        if (preferencesController != nil) {
            preferencesController!.showWindow(sender)
        }
    }

    @IBAction func onYesterday(_ sender: Any) {
        if let vc = NSApplication.shared.mainWindow?.contentViewController as? TodayViewController {
            vc.files.browser.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        }
    }
    
    @IBAction func onToday(_ sender: Any) {
        if let vc = NSApplication.shared.mainWindow?.contentViewController as? TodayViewController {
            vc.files.browser.selectRowIndexes(IndexSet(integer: 1), byExtendingSelection: false)
        }
    }
    
    @IBAction func onTomorrow(_ sender: Any) {
        if let vc = NSApplication.shared.mainWindow?.contentViewController as? TodayViewController {
            vc.files.browser.selectRowIndexes(IndexSet(integer: 2), byExtendingSelection: false)
        }
    }
    
    @IBAction func onSomeday(_ sender: Any) {
        if let vc = NSApplication.shared.mainWindow?.contentViewController as? TodayViewController {
            vc.files.browser.selectRowIndexes(IndexSet(integer: 3), byExtendingSelection: false)
        }
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        if let url = URL(string: "https://thmsbfft.info") {
            NSWorkspace.shared.open(url)
        }
    }
}

