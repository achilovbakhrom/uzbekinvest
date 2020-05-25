//
//  IncidentsAddEditAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsAddEditAssembly: BaseAssemblyProtocol {
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class IncidentsAddEditAssemblyImpl: IncidentsAddEditAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = LocationVC()
        let presenter = IncidentsAddEditPresenterImpl()
        let router = IncidentsAddEditRouterImpl(factory: self.factory, viewController: vc, presenter: presenter)
        let interactor = IncidentsAddEditInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
