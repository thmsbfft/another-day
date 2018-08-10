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
        
        
        print(somedayCheckbox.state)
    }
    
    func save() {

        // Save someday state
        if somedayCheckbox.state.rawValue == 0 {
            prefs.someday = false
        }
        else if somedayCheckbox.state.rawValue == 1 {
            prefs.someday = true
        }

        NotificationCenter.default.post(name: Notification.Name(rawValue: "preferences-changed"), object: nil)
    }
    
    @IBAction func somedayClicked(_ sender: NSButton) {
        print("click")
        print(somedayCheckbox.state.rawValue)
        save()
    }
    
    @IBAction func pickFolderClicked(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.title = "Select a folder to store notes"
        openPanel.message = "Videos you drop in the folder you select will be converted to animated gifs"
        openPanel.showsResizeIndicator=true;
        openPanel.canChooseDirectories = true;
        openPanel.canChooseFiles = false;
        openPanel.allowsMultipleSelection = false;
        openPanel.canCreateDirectories = true;
        
        openPanel.beginSheetModal(for:self.view.window!) { (response) in
            if response == .OK {
                let selectedPath = openPanel.url!.path
//                prefs.folder = selectedPath
                self.folderPath.url = openPanel.url!
            }
        }
    }
    
}
