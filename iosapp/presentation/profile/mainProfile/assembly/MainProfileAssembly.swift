//
//  MainProfileAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MainProfileAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var factory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class MainProfileAssemblyImpl: MainProfileAssembly {
    var mainStoryboard: UIStoryboard
    var factory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = MainProfileVC()
        let presenter = MainProfilePresenterImpl()
        let router = MainProfileRouterImpl(assemblyFactory: factory, viewController: vc)
        let interactor = MainProfileInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
}
