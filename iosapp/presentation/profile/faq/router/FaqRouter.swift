//
//  FaqRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol FaqRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
    func goBack()
}

class FaqRouterImpl: FaqRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = factory
        self.viewController = viewController
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
}
