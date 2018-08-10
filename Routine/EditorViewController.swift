//
//  EditorViewController.swift
//  today
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class EditorViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textView: NSTextView!
    
    var files:FilesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        disable()
    }
    
    func textDidChange(_ notification: Notification) {
        // Change depending on what is selected
        if let rtf = textView.rtf(from: NSMakeRange(0, textView.attributedString().length)) {
            let selectedName = files.files[files.browser.selectedRow]
            Configuration.writeFile(name: selectedName, content: rtf)
        }
    }
    
    func disable() {
        textView.string = ""
        textView.isEditable = false
        textView.isSelectable = false
    }
    
    func enable() {
        textView.isEditable = true
        textView.isSelectable = true
    }
    
    func update(withFile file: NSAttributedString) {
        textView.string = ""
        textView.textStorage?.append(file)
        enable()
    }
    
}
