//
//  UIButton+extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func active() {
        
        UIView.animate(withDuration: 0.4) {
            self.backgroundColor = Colors.primaryGreen
            self.setTitleColor(.white, for: .normal)
            self.layer.cornerRadius = 7
            self.layer.masksToBounds = true
            self.layoutIfNeeded()
        }
    }
    
    func inactive() {
        UIView.animate(withDuration: 0.4) {
            self.backgroundColor = UIColor.init(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 1.0)
            self.setTitleColor(.black, for: .normal)
            self.layer.cornerRadius = 7
            self.layer.masksToBounds = true
            self.layoutIfNeeded()
        }
        
    }
    
}
