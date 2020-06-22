//
//  OfferRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol OfferRouter: BaseRouter{
    func goBack()
    func openMain()
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
}

class OfferRouterImpl: OfferRouter {
    
    var factory: AssemblyFactoryProtocol?
    
    var viewController: UIViewController?
    
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openMain() {
        let vc = self.factory?.mainModule.assembleViewController() as! MainViewController
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = factory
        self.viewController = viewController
    }
    
}
