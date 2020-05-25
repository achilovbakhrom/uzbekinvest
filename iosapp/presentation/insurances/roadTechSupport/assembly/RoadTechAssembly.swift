//
//  RoadTechAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol RoadTechAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class RoadTechAssemblyImpl: RoadTechAssembly {
    
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "RoadTechSupportVC") as! RoadTechSupportVC
        let presenter = RoadTechPresenterImpl()
        let router = RoadTechRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        let interactor = RoadTechInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        vc.presenter = presenter
        return vc
    }
    
}
