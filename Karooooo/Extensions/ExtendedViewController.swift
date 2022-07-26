//
//  ExtendedViewController.swift
//  Karooooo
//
//  Created by Sachin on 26/07/22.
//

import UIKit

extension UIViewController{
    func showAlert(alertTitle: String?, alertMessage: String?, buttonTitles: [String],  style: UIAlertController.Style, action: ((String?) -> Void)?) {
        
        let alert = UIAlertController(title: alertTitle != nil ? alertTitle : Constant.shared.appName, message: alertMessage, preferredStyle: style)
        
        for buttonTitle in buttonTitles {
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler : {(alert: UIAlertAction!) in
                action?(buttonTitle)
            }))
        }
        
        if style == .actionSheet {
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler : nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
