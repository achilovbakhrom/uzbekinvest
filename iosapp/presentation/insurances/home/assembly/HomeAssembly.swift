//
//  HomeAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol HomeAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class HomeAssemblyImpl: HomeAssembly {
    
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = self.storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        let presenter = HomePresenterImpl()
        let interactor = HomeInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = HomeRouterImpl(factory: self.assemblyFactory, view: vc!, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc?.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
    
}
