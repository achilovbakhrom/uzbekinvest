//
//  IncidentsDetailAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsDetailAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class IncidentsDetailAssemblyImpl: IncidentsDetailAssembly {
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = IncidentsDetailListingVC()
        let presenter = IncidentsDetailPresenterImpl()
        let router = IncidentsDetailRouterImpl(factory: self.assemblyFactory, viewController: vc)
        let interactor = IncidentsDetailInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc        
        vc.presenter = presenter
        return vc
    }
}
