//
//  OfferAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol OfferAssembly: BaseAssemblyProtocol {
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class OfferAssemblyImpl: OfferAssembly {
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactoryProtocol
    var storyboard: UIStoryboard
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.factory = assemblyFactory
        self.storyboard = storyboard
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "OfferVC") as! OfferVC
        let presenter = OfferPresenterImpl()
        let interactor = OfferInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = OfferRouterImpl(factory: self.factory, viewController: vc)
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
