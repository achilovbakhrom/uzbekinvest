//
//  NotificationAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol NotificationAssembly: BaseAssemblyProtocol {
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class NotificationAssemblyImpl: NotificationAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = NotificationVC()
        let presenter = NotificationPresenterImpl()
        let interactor = NotificationInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = NotificationRouterImpl(factory: self.factory, viewController: vc)
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
