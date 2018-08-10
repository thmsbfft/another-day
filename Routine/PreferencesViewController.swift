//
//  PreferencesViewController.swift
//  today
//
//  Created by thmsbfft on 8/9/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    var prefs = Preferences()
    
    @IBOutlet var somedayCheckbox: NSButton!
    @IBOutlet var folderPath: NSPathControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show existing preferences
        
        if prefs.someday == false {
            somedayCheckbox.state = NSControl.StateValue.off
            
        }
        else if prefs.someday == true {
            somedayCheckbox.state = NSControl.StateValue.on
        }
        
        folderPath.url = prefs.folder
    }
    
    func save() {

        // save someday state
        if somedayCheckbox.state == NSControl.StateValue.off {
            prefs.someday = false
        }
        else if somedayCheckbox.state == NSControl.StateValue.on {
            prefs.someday = true
        }
        
        // save folder state
        prefs.folder = folderPath.url!

        NotificationCenter.default.post(name: Notification.Name(rawValue: "preferences-changed"), object: nil)
    }
    
    @IBAction func somedayClicked(_ sender: NSButton) {
        print("Someday: ", somedayCheckbox.state.rawValue)
        
        self.save()
    }
    
    @IBAction func pickFolderClicked(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.title = "Select a folder to store notes"
        openPanel.message = "Select a folder to store notes"
        openPanel.showsResizeIndicator=true;
        openPanel.canChooseDirectories = true;
        openPanel.canChooseFiles = false;
        openPanel.allowsMultipleSelection = false;
        openPanel.canCreateDirectories = true;
        
        openPanel.beginSheetModal(for:self.view.window!) { (response) in
            if response == .OK {
                print("New folder: ", openPanel.url!)
                self.folderPath.url = openPanel.url!
                self.save()
            }
        }
    }
    
}
