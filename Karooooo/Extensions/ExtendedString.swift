//
//  ExtendedString.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import Foundation

extension String {
    var isValidPassword: Bool {
        let passwordRegex: String = "^(?=.*[A-Z])(?=.*[0-9].*[0-9]).{8}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
