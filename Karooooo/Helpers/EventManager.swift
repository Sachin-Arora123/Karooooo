//
//  EventManager.swift
//  Karooooo
//
//  Created by Sachin on 26/07/22.
//

import UIKit

class EventManager: NSObject {
    
    var activityIndicator = UIActivityIndicatorView()
    static let shared = EventManager()
    
    override init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .appGreenColor
    }

    
    // MARK: -  Check for Internet 
//    class func checkForInternetConnection() -> Bool {
//        do{
//            if try Reachability().connection == .unavailable{
//                return false
//            }else{
//                return true
//            }
//        }catch{
//            print(error)
//            return false
//        }
//    }
    
    // MARK: -  Loader 
    func showloader() {
        if let scene : SceneDelegate = (Constant.shared.scene?.delegate as? SceneDelegate) {
            activityIndicator.startAnimating()
            scene.window?.addSubview(activityIndicator)
            scene.window?.bringSubviewToFront(activityIndicator)
            scene.window?.isUserInteractionEnabled = false
            
            activityIndicator.centerXAnchor.constraint(equalTo: scene.window!.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: scene.window!.centerYAnchor).isActive = true
        }
    }
    
    func hideloader() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
