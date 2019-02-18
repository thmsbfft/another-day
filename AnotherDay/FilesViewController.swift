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
    
    var prefs = Preferences()
    var files = ["yesterday", "today", "tomorrow"]
    
    override func viewDidLoad() {
        browser.delegate = self
        browser.headerView = nil
        browser.dataSource = self
        
        updateFromPrefs()
        
        NotificationCenter.default.addObserver(forName: Notification.Name("preferences-changed"), object: nil, queue: nil) { (notification) in
            self.updateFromPrefs()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("cycle-begin"), object: nil, queue: nil) { (notification) in
            // deselect before switching files
            print("deselecting")
            self.browser.deselectAll(self)
        }
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return CustomRowView()
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
        return 22
    }
    
    func tableViewSelectionIsChanging(_ notification: Notification) {
        if browser.selectedRow > -1 {
            browser.rowView(atRow: browser.selectedRow, makeIfNecessary: false)?.isEmphasized = false
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if (browser.selectedRow != -1) {
            // Read selected file
            let selectedName = files[browser.selectedRow]
            let file = Configuration.getFile(name: selectedName)

            // Update the editor
            editor.update(withFile: file)
            
            // Update window title
            self.parent?.view.window?.title = String(selectedName.uppercased().first!) + String(selectedName.dropFirst())
        }
        else {
            // Nothing is selected
            editor.disable()
        }
    }
    
    func updateFromPrefs() {
        let viewMenu = NSApplication.shared.mainMenu!.item(at: 3)!
        let selectedBefore = browser.selectedRow
        if prefs.someday {
            files = files.filter() {$0 != "someday" }
            files.append("someday")
            viewMenu.submenu?.item(withTitle: "Someday")?.isEnabled = true
        }
        else {
            files = files.filter() {$0 != "someday" }
            viewMenu.submenu?.item(withTitle: "Someday")?.isEnabled = false
        }
        browser.reloadData()
        
        if editor != nil {
            if prefs.someday == false && selectedBefore == 3 {
                editor.disable()
            }
            else {
                browser.selectRowIndexes([selectedBefore], byExtendingSelection: false)
            }
        }
    }
}

class CustomRowView: NSTableRowView {
    
    override var isEmphasized: Bool {
        set {}
        get {
            return true
        }
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        NSColor(named: NSColor.Name("sidebarHighlightControlColor"))?.setFill()
        dirtyRect.fill()
    }
    
}
