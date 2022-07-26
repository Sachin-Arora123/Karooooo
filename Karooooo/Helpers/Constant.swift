//
//  Constant.swift
//  Karooooo
//
//  Created by Sachin on 26/07/22.
//

import Foundation
import UIKit

class Constant: NSObject {
    
    static let shared        = Constant()
    let appName              = "Karooooo"
//    let appDelegate          = UIApplication.shared.delegate as! AppDelegate
    let scene                = UIApplication.shared.connectedScenes.first
    let api                  = API()
//    let message              = AppMessage()
}

struct API {
    let baseURL              = "https://jsonplaceholder.typicode.com"
    let getApi               = "GET"
    let getUsers            = "/users"
}
