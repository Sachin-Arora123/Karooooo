//
//  Person.swift
//  Karooooo
//
//  Created by Sachin on 24/07/22.
//

import Foundation

class Person {
    var id: Int = 0
    var username: String = ""
    var password: String = ""
    var country: String = ""
    init(id: Int, username: String, password: String, country: String) {
        self.id       = id
        self.username = username
        self.password = password
        self.country  = country
    }
}
