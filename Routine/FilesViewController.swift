//
//  FilesViewController.swift
//  today
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class FilesViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var browser: NSTableView!
    
    var editor:EditorViewController!
    
    let files = ["yesterday", "today", "tomorrow"]
    
    override func viewDidLoad() {
        browser.delegate = self
        browser.headerView = nil

        browser.dataSource = self
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "template"), owner: nil) as? NSTableCellView
        cell?.textField?.stringValue = files[row]
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 19
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if (browser.selectedRow != -1) {
            // Read selected file
            let selectedName = files[browser.selectedRow]
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
