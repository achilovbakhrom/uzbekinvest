//
//  BaseRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRouter: class {
    var factory: AssemblyFactoryProtocol? { get set }
    var viewController: UIViewController? { get set }
}

extension BaseRouter {
func getPrevVC() -> UIViewController? {
        let count = self.viewController?.navigationController?.viewControllers.count ?? 0;        
        if (count >= 2) {
            return self.viewController?.navigationController?.viewControllers[count-2]
        }
        return nil
    }
}
