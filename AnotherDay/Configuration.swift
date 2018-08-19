//
//  Configuration.swift
//  Routine
//
//  Created by thmsbfft on 8/8/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Cocoa

class Configuration {
    
    static func getPath() -> URL {
        return Preferences().folder
    }
    
    static func getFile(name: String) -> String {
        let fileURL = getPath().appendingPathComponent(name).appendingPathExtension("txt")
        
        // Check that file exists
        let fileManager = FileManager.default
        if !(fileManager.fileExists(atPath: fileURL.path)) {
            print("File doesn't exist, creating a new one...")
            createDefaultFile(atURL: fileURL)
        }
        
        var content = ""
        do {
            try content = String(contentsOf: fileURL, encoding: .utf8)
        } catch let error as NSError {
            print("Failed to retrieve file")
            print(error)
        }
        return content
    }
    
    static func writeFile(name: String, content: String) {
        let fileURL = getPath().appendingPathComponent(name).appendingPathExtension("txt")
        
        do {
            try content.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch let error as NSError {
            print("Failed")
            print(error)
        }
    }
    
    static func createDefaultFile(atURL url: URL) {      
        let newFile = " 🌱 "
        
        // Save new file to disk
        do {
            try newFile.write(to: url, atomically: false, encoding: .utf8)
        } catch let error as NSError {
            print(error)
        }
    }
    
}
