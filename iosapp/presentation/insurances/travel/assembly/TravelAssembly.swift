//
//  TravelAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol TravelAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class TravelAssemblyImpl: TravelAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.storyboard = storyboard
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = self.storyboard.instantiateViewController(withIdentifier: "TravelVC") as! TravelVC
        let presenter = TravelPresenterImpl()
        let router = TravelRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        let interactor = TravelInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
}
