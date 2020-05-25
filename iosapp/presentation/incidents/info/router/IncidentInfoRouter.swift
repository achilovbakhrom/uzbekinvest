//
//  IncidentInfoRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentInfoRouter: BaseRouter {
    func goBack()
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
}

class IncidentInfoRouterImpl: IncidentInfoRouter {
    
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

