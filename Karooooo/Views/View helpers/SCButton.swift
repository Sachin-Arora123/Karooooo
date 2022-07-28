//
//  SCButton.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import UIKit

@IBDesignable
public class SCButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
         didSet {
            layer.borderColor = borderColor?.cgColor
         }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
