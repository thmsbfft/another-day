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
                fontSize = 20
            case "Large":
                fontSize = 26
            default:
                fontSize = 14
        }
        
        // font family
        var font: NSFont
        switch prefs.font {
            case "System":
                font = NSFont.systemFont(ofSize: fontSize)
            case "Serif":
                font = NSFont(name: "Charter Roman", size: fontSize)!
            case "Mono":
                font = NSFont(name: "Monaco", size: fontSize)!
            default:
                font = NSFont.systemFont(ofSize: fontSize)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        
        let attributes: [NSAttributedStringKey : Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString.init(string: file, attributes: attributes)
        
        textView.string = ""
        textView.textStorage?.append(attributedString)
        enable()
    }
    
}
