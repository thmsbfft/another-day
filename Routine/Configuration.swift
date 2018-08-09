//
//  Configuration.swift
//  Routine
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Foundation

class Configuration {
    static let path = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop").appendingPathComponent("Routine")
    
    static func getFile(name: String) -> NSAttributedString {
        let fileURL = path.appendingPathComponent(name).appendingPathExtension("rtf")
        // TODO: Check that file exists
        var content: NSAttributedString!
        do {
            content = try NSAttributedString(url: fileURL, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
        } catch let error as NSError {
            print("Failed to retrieve file")
            print(error)
        }
        return content
    }
    
    static func writeFile(name: String, content: Data) {
        let fileURL = path.appendingPathComponent(name).appendingPathExtension("rtf")
        
        do {
            try content.write(to: fileURL)
        } catch let error as NSError {
            print("Failed")
            print(error)
        }
    }
}
