//
//  TodayWindowController.swift
//  Routine
//
//  Created by thmsbfft on 8/11/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class TodayWindowController: NSWindowController, NSWindowDelegate {
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        self.window?.orderOut(sender)
        return false
    }
    
}
