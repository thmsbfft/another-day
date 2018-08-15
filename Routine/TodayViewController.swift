//
//  TodayViewController.swift
//  Routine
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class TodayViewController: NSSplitViewController {

    @IBOutlet weak var left: NSSplitViewItem!
    @IBOutlet weak var right: NSSplitViewItem!
    
    var files:FilesViewController!
    var editor:EditorViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let files = left.viewController as? FilesViewController,
           let editor = right.viewController as? EditorViewController {
            
            self.files = files
            self.editor = editor
        
            files.editor = editor
            editor.files = files
            
            files.browser.selectRowIndexes([1], byExtendingSelection: false)
        }
    }
}
