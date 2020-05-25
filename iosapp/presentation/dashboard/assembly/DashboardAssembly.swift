//
//  DashboardAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var factory: AssemblyFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactoryProtocol)
}


class DashboardAssemblyImpl: DashboardAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var mainStoryboard: UIStoryboard
    var factory: AssemblyFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactoryProtocol) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = DashboardVC()
        let presenter = DashboardPresenterImpl()
        vc.presenter = presenter
        let interactor = DashboardInteractorImpl(serviceFactory: self.serviceFactory, assembly: self.factory)
        presenter.interactor = interactor
        presenter.view = vc
        interactor.presenter = presenter
        let router = DashboardRouterImpl(factory: self.factory, viewController: vc)        
        presenter.router = router
        return vc
    }
    
}
