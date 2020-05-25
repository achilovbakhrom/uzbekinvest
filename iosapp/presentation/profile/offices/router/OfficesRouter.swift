//
//  OfficesInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol OfficesRouter: BaseRouter {
    init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController)
    func goBack()
}

class OfficesRouterImpl: OfficesRouter {
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = assemblyFactory
        self.viewController = viewController
    }
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}

