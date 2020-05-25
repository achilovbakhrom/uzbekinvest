//
//  UIScrollView+Extension.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

extension UIScrollView {
    var currentPage: Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)
    }
}


extension UIScrollView {
    func scrollTo(horizontalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = -90
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
}
