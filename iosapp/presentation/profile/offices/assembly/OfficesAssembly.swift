//
//  OfficesAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol OfficesAssembly: BaseAssemblyProtocol {
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class OfficesAssemblyImpl: OfficesAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = OfficesVC()
        let presenter = OfficesPresenterImpl()
        let interactor = OfficesInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = OfficesRouterImpl(assemblyFactory: self.factory, viewController: vc)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
}
