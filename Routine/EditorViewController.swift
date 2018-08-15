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
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.textContainerInset = NSMakeSize(20, 20)
    }
    
    func textDidChange(_ notification: Notification) {
        // Change depending on what is selected
        
        let selectedName = files.files[files.browser.selectedRow]
        Configuration.writeFile(name: selectedName, content: textView.string)
    }
    
    func disable() {
        textView.string = ""
        textView.isEditable = false
        textView.isSelectable = false
        
        // update window title
        self.parent?.view.window?.title = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    func enable() {
        textView.isEditable = true
        textView.isSelectable = true
    }
    
    func update(withFile file: String) {
        
        // font size
        var fontSize: CGFloat = 14
        switch prefs.size {
            case "Small":
                fontSize = 14
            case "Medium":
                fontSize = 18
            case "Large":
                fontSize = 24
            default:
                fontSize = 14
        }
        
        // font family
        var font: NSFont
        var lineSpacing: CGFloat
        switch prefs.font {
            case "System":
                font = NSFont.systemFont(ofSize: fontSize)
                lineSpacing = 2
            case "Serif":
                font = NSFont(name: "Spectral Regular", size: fontSize*1.2)!
                lineSpacing = -4
            case "Mono":
                font = NSFont(name: "Space Mono", size: fontSize)!
                lineSpacing = 2.0
            default:
                font = NSFont.systemFont(ofSize: fontSize)
                lineSpacing = 2
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        textView.string = file
        textView.font = font
        textView.defaultParagraphStyle = paragraphStyle
        
        enable()
    }
    
}
