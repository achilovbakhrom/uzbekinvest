//
//  InsuranceListAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol InsuranceListAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var factory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class InsuranceListAssemblyImpl: InsuranceListAssembly {
    var mainStoryboard: UIStoryboard
    var factory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = InsuranceListVC()
        let presenter = InsuranceListPresenterImpl()
        let router = InsuranceListRouterImpl(factory: self.factory, viewController: vc)
        let interactor = InsuranceListInteractorImpl(serviceFactory: self.serviceFactory, assembly: self.factory, presenter: presenter)        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
}
