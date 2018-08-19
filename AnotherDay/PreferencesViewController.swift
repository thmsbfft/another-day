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
    
    @IBOutlet var fontMenu: NSPopUpButton!
    @IBOutlet var sizeMenu: NSPopUpButton!
    @IBOutlet var folderMenu: NSPopUpButton!
    @IBOutlet var somedaySegment: NSSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show existing preferences
        updateViewFromPreferences()
    }
    
    override func viewWillAppear() {
//        updateViewFromPreferences()
    }
    
    func updateViewFromPreferences() {
        
        // font
        fontMenu.selectItem(withTitle: prefs.font)
        
        // size
        sizeMenu.selectItem(withTitle: prefs.size)
        
        // folder
        folderMenu.item(at: 0)?.title = prefs.folder.pathComponents.last!
        
        // someday
        if prefs.someday == false {
            somedaySegment.selectSegment(withTag: 1)
        }
        else if prefs.someday == true {
            somedaySegment.selectSegment(withTag: 0)
        }
        
    }

    func save() {

        // font
        prefs.font = fontMenu.selectedItem!.title
        
        // size
        prefs.size = sizeMenu.selectedItem!.title
        
        // someday state
        if somedaySegment.selectedSegment == 1 {
            prefs.someday = false
        }
        else if somedaySegment.selectedSegment == 0 {
            prefs.someday = true
        }

        NotificationCenter.default.post(name: Notification.Name(rawValue: "preferences-changed"), object: nil)
    }
    
    @IBAction func fontMenuChanged(_ sender: NSPopUpButton) {
        save()
    }
    
    @IBAction func sizeMenuChanged(_ sender: NSPopUpButton) {
        save()
    }
    
    @IBAction func folderMenuChanged(_ sender: NSPopUpButton) {
        if sender.selectedItem!.title == "Pick a folder..." {
            pickFolderClicked()
        }
    }
    
    @IBAction func somedayChanged(_ sender: NSSegmentedControl) {
        save()
    }
    
    func pickFolderClicked() {
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
                self.prefs.folder = openPanel.url!
                self.folderMenu.item(at: 0)?.title = self.prefs.folder.pathComponents.last!
            }
        }
    }

    @IBAction func viewFolderClicked(_ sender: NSButton) {
        NSWorkspace.shared.activateFileViewerSelecting([prefs.folder])
    }
}
