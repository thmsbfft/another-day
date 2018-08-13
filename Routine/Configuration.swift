//
//  Configuration.swift
//  Routine
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Foundation

class Configuration {
    
    static func getPath() -> URL {
        return Preferences().folder
    }
    
    static func getFile(name: String) -> NSAttributedString {
        let fileURL = getPath().appendingPathComponent(name).appendingPathExtension("rtf")
        
        // Check that file exists
        let fileManager = FileManager.default
        if !(fileManager.fileExists(atPath: fileURL.path)) {
            print("File doesn't exist, creating a new one...")
            createDefaultFile(atURL: fileURL)
        }
        
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
        let fileURL = getPath().appendingPathComponent(name).appendingPathExtension("rtf")
        
        do {
            try content.write(to: fileURL)
        } catch let error as NSError {
            print("Failed")
            print(error)
        }
    }
    
    static func createDefaultFile(atURL url: URL) {
        let newFileAttributedString = NSAttributedString.init(string: "🌱")
        let newFileAttributedData: Data! = newFileAttributedString.rtf(from: NSMakeRange(0, newFileAttributedString.length))
        
        // Save new file to disk
        do {
            try newFileAttributedData.write(to: url)
        } catch let error as NSError {
            print(error)
        }
    }
    
}
