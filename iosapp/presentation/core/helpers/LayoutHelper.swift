//
//  LayoutConstraint.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/6/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

@IBDesignable class LayoutHelper : NSLayoutConstraint {
    
    @IBInspectable var iPhone4OrNewer: CGFloat = 0.0 {
        didSet {
            if isIPhone4OrNewer() {
                constant = iPhone4OrNewer
            }
        }
    }
        
    @IBInspectable var iPhoneSE: CGFloat = 0.0 {
        didSet {
            if isIPhoneSE() {
                constant = iPhoneSE
            }
        }
    }
    
    @IBInspectable var iPhonePlus: CGFloat = 0.0 {
        didSet {
            if isIPhonePlus() {
                constant = iPhonePlus
            }
        }
    }
    
    @IBInspectable var iPhoneXOrHigher: CGFloat = 0.0 {
        didSet {
            if isIPhoneXOrHigher() {
                constant = iPhoneXOrHigher
            }
        }
    }
    
}

