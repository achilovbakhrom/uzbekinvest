//
//  OrderCheckAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol OrderCheckAssembly: BaseAssemblyProtocol {
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class OrderCheckAssemblyImpl: OrderCheckAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = OrderCheck1VC()
        let presenter = OrderCheckPresenterImpl()
        let router = OrderCheckRouterImpl(factory: self.factory, viewController: vc, presenter: presenter)
        let interactor = OrderCheckInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
