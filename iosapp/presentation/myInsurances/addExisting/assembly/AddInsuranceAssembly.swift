//
//  AddInsuranceAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol AddInsuranceAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    var serviceFactory: ServiceFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class AddInsuranceAssemblyImpl: AddInsuranceAssembly {
    var mainStoryboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = SwitcherVC()
        let presenter = AddingInsurancePresenterImpl()
        let interactor = AddingInsuranceInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = AddInsuranceRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter        
        return vc
    }
    
    
    
    
}
