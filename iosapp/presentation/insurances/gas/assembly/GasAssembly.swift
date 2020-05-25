//
//  GasAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol GasAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class GasAssemblyImpl: GasAssembly {
    
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
        self.storyboard = storyboard
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "GasVC") as! GasVC
        let presenter = GasPresenterImpl()
        let interactor = GasInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = GasRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
