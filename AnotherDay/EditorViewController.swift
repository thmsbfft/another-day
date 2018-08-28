//
//  EditorViewController.swift
//  today
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class EditorViewController: NSViewController, NSTextViewDelegate, NSTextStorageDelegate {
    
    @IBOutlet var textView: NSTextView!
    
    var files:FilesViewController!
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.textContainerInset = NSMakeSize(20, 20)
    }
    
    func textDidChange(_ notification: Notification) {
        // change depending on what is selected
        let selectedName = files.files[files.browser.selectedRow]
        Configuration.writeFile(name: selectedName, content: textView.string)
        
        // update paragraph style
        textView.textStorage?.addAttribute(.paragraphStyle, value: getDefaultParagraphStyle(), range: NSMakeRange(0, textView.textStorage!.length))
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
    
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        textStorage.addAttributes([.paragraphStyle : getDefaultParagraphStyle()], range: editedRange)
    }
    
    func getDefaultParagraphStyle () -> NSParagraphStyle {
        var lineSpacing: CGFloat
        
        switch prefs.font {
        case "System":
            lineSpacing = 4
        case "Serif":
            lineSpacing = 0
        case "Mono":
            lineSpacing = 2.0
        default:
            lineSpacing = 2.0
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        return paragraphStyle
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
        switch prefs.font {
            case "System":
                font = NSFont.systemFont(ofSize: fontSize)
            case "Serif":
                font = NSFont(name: "Spectral Regular", size: fontSize*1.2)!
            case "Mono":
                font = NSFont(name: "Space Mono", size: fontSize)!
            default:
                font = NSFont.systemFont(ofSize: fontSize)
        }
        
        textView.textStorage?.addAttribute(.paragraphStyle, value: getDefaultParagraphStyle(), range: NSMakeRange(0, textView.textStorage!.length))
        textView.defaultParagraphStyle = getDefaultParagraphStyle()
        textView.string = file
        textView.font = font
        
        enable()
    }
    
}
