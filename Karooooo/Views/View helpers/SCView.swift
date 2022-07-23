//
//  SCView.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import UIKit

@IBDesignable
public class SCView: UIView
{
   
    
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
    
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth

        }
    }
    
}
