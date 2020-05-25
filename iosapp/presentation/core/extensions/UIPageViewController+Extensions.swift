//
//  UIPageViewController+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
                delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [currentViewController], transitionCompleted: true)
            }
        }
    }
    
    func goToPrevPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) {
                setViewControllers([nextPage], direction: .reverse, animated: animated, completion: completion)
                delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [currentViewController], transitionCompleted: true)
            }
        }
    }
}
