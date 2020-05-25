//
//  ConfirmAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit


protocol ConfirmAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    var serviceFactory: ServiceFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class ConfirmAssemblyImpl: ConfirmAssembly {
    
    var mainStoryboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.mainStoryboard = storyboard
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ConfirmVC") as! ConfirmVC
        let presenter = ConfirmPresenterImpl()
        vc.presenter = presenter
        presenter.view = vc
        let router = ConfirmRouterImpl()
        router.factory = self.assemblyFactory
        router.viewController = vc
        presenter.router = router
        let interactor = ConfirmInteractorImpl(serviceFactory: self.serviceFactory)
        interactor.presenter = presenter
        presenter.interactor = interactor
        return vc
    }
    
    
    
}
