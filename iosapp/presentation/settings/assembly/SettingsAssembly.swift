//
//  File.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol SettingsAssembly: BaseAssemblyProtocol {
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class SettingsAssemblyImpl: SettingsAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = SettingsVC()
        let presenter = SettingsPresenterImpl()
        let interactor = SettingsInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = SettingsRouterImpl(factory: self.factory, viewController: vc, basePresenter: presenter)
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
    
}
