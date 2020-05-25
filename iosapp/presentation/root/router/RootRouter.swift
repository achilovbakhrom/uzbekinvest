//
//  RootRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol RootRouterProtocol: BaseRouter {
    
    func openStartPage()
    func openMainPage()
    func openLoginPage()
}

class RootRouter: RootRouterProtocol {
    
    var factory: AssemblyFactoryProtocol? = nil
    var viewController: UIViewController? = nil
    
    init(viewController: UIViewController?, factory: AssemblyFactoryProtocol) {
        self.viewController = viewController
        self.factory = factory
    }
    
    func openStartPage() {
        let vc = factory?.welcomeModule.assembleViewController()
        self.viewController?.navigationController?.setViewControllers([vc!], animated: false)
    }
    
    func openMainPage() {
        guard let vc = factory?.mainModule.assembleViewController()! else { return }
        self.viewController?.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func openLoginPage() {
        guard let vc = factory?.loginModule.assembleViewController()! else { return  }
        self.viewController?.navigationController?.setViewControllers([vc], animated: false)
    }
    
}
