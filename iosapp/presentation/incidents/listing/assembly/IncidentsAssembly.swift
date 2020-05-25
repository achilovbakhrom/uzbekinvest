//
//  IncidentsAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//


import UIKit

protocol IncidentsAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class IncidentsAssemblyImpl: IncidentsAssembly {
    var storyboard: UIStoryboard
    var serviceFactory: ServiceFactoryProtocol
    var assemblyFactory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
        self.storyboard = storyboard
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = IncidentViewController()
        let presenter = IncidentsListingPresenterImpl()
        let router = IncidentsListingRouterImpl(factory: self.assemblyFactory, viewController: vc)
        let interactor = IncidentsInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
