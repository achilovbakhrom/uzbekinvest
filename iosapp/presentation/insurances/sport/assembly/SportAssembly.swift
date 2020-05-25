//
//  SportAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol SportAssembly: BaseAssemblyProtocol {
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class SportAssemblyImpl: SportAssembly {
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = assemblyFactory.storyboardModule.main.instantiateViewController(withIdentifier: "SportVC") as! SportVC
        let presenter = SportsPresenterImpl()
        let interactor = SportInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = SportsRouterImpl(assemblyFactory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
    
    
}
