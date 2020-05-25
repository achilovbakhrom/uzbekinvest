//
//  MyInsurancesAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MyInsranceAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class MyInsuranceAssemblyImpl: MyInsranceAssembly {
    
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = MyInsuranceVC()
        let presenter = MyInsurancesPresenterImpl()
        let interactor = MyInsranceInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = MyInsrancesRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.router = router
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        return vc
    }
    
}
