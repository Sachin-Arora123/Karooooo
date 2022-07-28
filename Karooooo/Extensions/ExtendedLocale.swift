//
//  ExtendedLocale.swift
//  Karooooo
//
//  Created by Sachin on 24/07/22.
//

import Foundation

extension NSLocale {
    // get an array of country names from NSlocale
    class func getCountryNames() -> [String] {
        var countryNames = [String]()
        for localeCode in NSLocale.isoCountryCodes {
            let countryName = (NSLocale.current as NSLocale).displayName(forKey: .countryCode, value: localeCode) ?? ""
            countryNames.append(countryName)
        }
        return countryNames
    }

}
