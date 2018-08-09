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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        let d = Configuration.getFile(name: "today-test")
//        print(d)
        
        if let files = left.viewController as? FilesViewController,
           let editor = right.viewController as? EditorViewController {
        
            files.editor = editor
            editor.files = files
        }
    }
    
}
