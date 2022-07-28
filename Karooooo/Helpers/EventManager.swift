//
//  EventManager.swift
//  Karooooo
//
//  Created by Sachin on 26/07/22.
//

import UIKit

class EventManager: NSObject {
    // MARK: -  Check for Internet 
    class func checkForInternetConnection() -> Bool {
        do {
            if try Reachability().connection == .unavailable {
                return false
            } else {
                return true
            }
        } catch {
            print(error)
            return false
        }
    }
}
