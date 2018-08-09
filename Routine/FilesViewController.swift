//
//  FilesViewController.swift
//  today
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class FilesViewController: NSViewController, NSBrowserDelegate {

    @IBOutlet var browser: NSBrowser!
    
    var editor:EditorViewController!
    
    let files = ["yesterday", "today", "tomorrow"]
    
    override func viewDidLoad() {
        browser.delegate = self
        
    }
    
    func browser(_ sender: NSBrowser, numberOfRowsInColumn column: Int) -> Int {
        return files.count
    }
    
    func browser(_ sender: NSBrowser, willDisplayCell cell: Any, atRow row: Int, column: Int) {
        if let cell = cell as? NSBrowserCell {
            cell.stringValue = files[row]
            cell.isLeaf = true
        }
    }

    @IBAction func onSelect(_ sender: Any) {
        if (browser.selectedRow(inColumn: 0) != -1) {
            
            // Read selected file
            let selectedName = files[browser.selectedRow(inColumn: 0)]
            let file = Configuration.getFile(name: selectedName)
            
            // Update the editor
            editor.update(withFile: file)
        }
        else {
            
            // Nothing is selected
            editor.disable()
        }
    }
}
