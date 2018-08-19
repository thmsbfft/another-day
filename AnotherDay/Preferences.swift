//
//  Preferences.swift
//  today
//
//  Created by thmsbfft on 8/9/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Foundation

struct Preferences {
    
    var font: String {
        get {
            let defaultFont = "System"
            
            if let setFont = UserDefaults.standard.string(forKey: "font") {
                return setFont
            }
            
            UserDefaults.standard.set(defaultFont, forKey: "font")
            return defaultFont
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "font")
        }
    }
    
    var size: String {
        get {
            let defaultSize = "Small"
            
            if let setSize = UserDefaults.standard.string(forKey: "size") {
                return setSize
            }
            
            UserDefaults.standard.set(defaultSize, forKey: "size")
            return defaultSize
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "size")
        }
    }
    
    var someday: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "someday")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "someday")
        }
    }
    
    var folder: URL {
        get {
            let path = UserDefaults.standard.url(forKey: "folder")
            let fileManager = FileManager.default
            
            // check if preference is set
            if path != nil {
                var isDir: ObjCBool = false
                if (fileManager.fileExists(atPath: path!.path, isDirectory: &isDir)) {
                    // the folder exists
                    // return the path
                    return path!
                }
                // the folder doesn't exist (moved or trashed)
                // we'll fallback on the default folder...
            }
            
            // create a default folder
            let defaultPath = fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Documents").appendingPathComponent("Another Day")
            do {
                try fileManager.createDirectory(atPath: defaultPath.path, withIntermediateDirectories: false)
            } catch {
                print(error)
            }
            
            // set the default path
            UserDefaults.standard.set(defaultPath, forKey: "folder")
            
            // return the default path
            return defaultPath
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "folder")
        }
    }
    
}
