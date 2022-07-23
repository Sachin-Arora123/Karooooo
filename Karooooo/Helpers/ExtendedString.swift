//
//  ExtendedString.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import Foundation
import UIKit

extension String {
    // Must be between 8 - 16 characters with at least 1 of any of the following capital letter,
    //two numbers
    public func isValidPassword() -> Bool {
//        let passwordRegex: String = "^(?=.*[A-Z])(?=.*[!@#$&*]).{8,}$"
        let passwordRegex: String = "^(?=.*[A-Z])(?=.*[0-9].*[0-9]).{8}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
