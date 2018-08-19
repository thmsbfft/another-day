//
//  Cycle.swift
//  Routine
//
//  Created by thmsbfft on 8/12/18.
//  Copyright © 2018 thmsbfft. All rights reserved.
//

import Foundation

class Cycle {
    
    static func initCycleCheck() {
        
        var lastUpdate = UserDefaults.standard.object(forKey: "last-update") as? Date
        if lastUpdate == nil {
            print("First launch, initializing")
            UserDefaults.standard.set(Date(), forKey: "last-update")
        }
        lastUpdate = UserDefaults.standard.object(forKey: "last-update") as? Date
        
        if shouldDoCycle() {
            doCycle()
        }
        Timer.scheduledTimer(withTimeInterval: 60*10, repeats: true, block: { (timer) in
            if shouldDoCycle() {
                doCycle()
            }
        })
//        doCycle() // test cycle
    }
    
    static func shouldDoCycle() -> Bool {
        
        // check date against last-updated date
        // if date is within next day of last-update, return true
        
        let currentDate = Date()
        let lastUpdate = UserDefaults.standard.object(forKey: "last-update") as? Date
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: currentDate)
        let lastUpdateDay = calendar.component(.day, from: lastUpdate!)
        
        print("Current day: ", currentDay)
        print("Last update day: ", lastUpdateDay)
        
        if currentDay > lastUpdateDay {
            return true
        }
        else if lastUpdateDay > currentDay {
            // this shouldn't happen but if it does
            // reset lastUpdate to the currentDay
            UserDefaults.standard.set(Date(), forKey: "last-update")
        }
        return false
    }
    
    static func doCycle() {
        // update last-update with today's date
        UserDefaults.standard.set(Date(), forKey: "last-update")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "cycle-begin"), object: nil)
        
        print("Doing cycle")
        let fileManager = FileManager.default
        let folder = Preferences().folder
        
        // TODO: add preference for /before
        // if it is checked, archive, otherwise delete
        
        // yesterday is removed
        do {
            try fileManager.removeItem(at: folder.appendingPathComponent("yesterday").appendingPathExtension("txt"))
        } catch {
            print(error)
        }
        
        // today becomes yesterday
        do {
            try fileManager.moveItem(at: folder.appendingPathComponent("today").appendingPathExtension("txt"), to: folder.appendingPathComponent("yesterday").appendingPathExtension("txt"))
        } catch {
            print(error)
        }
        
        // tomorrow becomes today
        do {
            try fileManager.moveItem(at: folder.appendingPathComponent("tomorrow").appendingPathExtension("txt"), to: folder.appendingPathComponent("today").appendingPathExtension("txt"))
        } catch {
            print(error)
        }
        
        // create a new tomorrow
        let tomorrowURL = folder.appendingPathComponent("tomorrow").appendingPathExtension("txt")
        Configuration.createDefaultFile(atURL: tomorrowURL)
    }
    
    static func backupYesterday() {
        let fileManager = FileManager.default
        let folder = Preferences().folder
        
        // create yesterday's date for archive
        let calendar = Calendar.current
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date())
        let archYear = calendar.component(.year, from: twoDaysAgo!)
        
        let archMonthInt = calendar.component(.month, from: twoDaysAgo!)
        let archMonth = String(format: "%02d", archMonthInt)
        let archDayInt = calendar.component(.day, from: twoDaysAgo!)
        let archDay = String(format: "%02d", archDayInt)
        
        let archiveDate = String(archYear) + "-" + String(archMonth) + "-" + String(archDay)
        
        // check if /before exists
        var isDir: ObjCBool = false
        if !(fileManager.fileExists(atPath: folder.appendingPathComponent("before").path, isDirectory: &isDir)) {
            do {
                try fileManager.createDirectory(atPath: folder.appendingPathComponent("before").path, withIntermediateDirectories: false)
            } catch {
                print(error)
            }
        }
        
        // yesterday is archived
        do {
            try fileManager.moveItem(at: folder.appendingPathComponent("yesterday").appendingPathExtension("txt"), to: folder.appendingPathComponent("before").appendingPathComponent(archiveDate).appendingPathExtension("txt"))
        } catch {
            print(error)
        }
    }
    
}
