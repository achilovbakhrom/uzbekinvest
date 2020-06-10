//
//  UIViewController+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import TTGSnackbar

extension UIViewController {

    func addViewController(_ viewController: UIViewController, frame: CGRect, completion: (() -> Void)?) {
        viewController.willMove(toParent: self)
        viewController.beginAppearanceTransition(true, animated: true)
        addChild(viewController)
        viewController.view.frame = frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.endAppearanceTransition()
        completion?()
    }
    
}

extension UIViewController {

    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.3) {
        if animated {
            if let frame = self.tabBarController?.tabBar.frame {
                let factor: CGFloat = hidden ? 1 : -1
                let y = frame.origin.y + (frame.size.height * factor)
                UIView.animate(withDuration: duration, animations: {
                    self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
                })
                return
            }
        }
        self.tabBarController?.tabBar.isHidden = hidden
    }
    
}

extension UIViewController {
    
    func showErrorMessage(msg: String) {
        let snackbar = TTGSnackbar(
            message: msg,
            duration: .middle
        )
        snackbar.backgroundColor = UIColor.init(red: 255.0/255.0, green: 116.0/255, blue: 118.0/255.0, alpha: 1.0)
        snackbar.show()
    }
    
    func showSuccessMessage(msg: String) {
        let snackbar = TTGSnackbar(
            message: msg,
            duration: .middle
        )
        snackbar.backgroundColor = Colors.primaryGreen
        snackbar.show()        
    }
}

extension UIViewController {
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
}
