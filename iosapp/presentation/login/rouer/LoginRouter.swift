//
//  File.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: BaseRouter {
    func openRegistration(phone: String)
    func openSlider()
    func openConfirm(phone: String)
}

class LoginRouter: LoginRouterProtocol {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = factory
        self.viewController = viewController
    }
    
    func openRegistration(phone: String) {
        let vc = (factory?.registerModule.assembleViewController() ?? UIViewController()) as! Registration1VC
        vc.phone = phone
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func openSlider() {
        let vc = factory?.registerModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func openConfirm(phone: String) {
        let vc = (factory?.confirmModule.assembleViewController() ?? UIViewController()) as! ConfirmVC
        vc.phone = phone
        vc.hasStarted = true
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
