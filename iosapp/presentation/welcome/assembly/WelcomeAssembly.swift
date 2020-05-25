//
//  WelcomeAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol WelcomeAssemblyProtocol: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class WelcomeAssembly: WelcomeAssemblyProtocol {
    
    var mainStoryboard: UIStoryboard
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let presenter = WelcomePresenter()
        let router = WelcomeRouter()
        router.factory = self.factory
        let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC
        router.viewController = vc
        presenter.router = router
        let interactor = WelcomeInteractor(storage: serviceFactory.storage)
        interactor.presenter = presenter
        vc?.presenter = presenter
        presenter.interactor = interactor
        return vc
    }
}
