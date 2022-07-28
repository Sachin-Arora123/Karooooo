//
//  ExtendedView.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import UIKit

extension UIView {
    func showRedBorder(_ status: Bool) {
        if status {
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        } else {
            self.layer.borderWidth = 0.0
        }
    }
}
