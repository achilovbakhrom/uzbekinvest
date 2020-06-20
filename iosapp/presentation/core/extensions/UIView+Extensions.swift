//
//  UIView+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    class func fromNib<T: UIView>(nibName: String, identifier: String) -> T {
        _ = Bundle(for: T.self).loadNibNamed(nibName, owner: nil, options: nil)
        
        return UIView() as! T
    }
}
