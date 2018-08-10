//
//  Preferences.swift
//  today
//
//  Created by thmsbfft on 8/9/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Foundation

struct Preferences {
    
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
//            let path = UserDefaults.standard.url?(forKey: "folder")
//            
//            if path != nil {
//                return path
//            }
            
            // return a default path
            return FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop").appendingPathComponent("Routine")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "folder")
        }
    }
    
}
