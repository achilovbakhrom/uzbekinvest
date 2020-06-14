//
//  FaqAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol FaqAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var factory: AssemblyFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol, mainStoryboard: UIStoryboard, assemblyFactory: AssemblyFactoryProtocol)
}

class FaqAssemblyImpl: FaqAssembly {
    var mainStoryboard: UIStoryboard
    var factory: AssemblyFactoryProtocol
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, mainStoryboard: UIStoryboard, assemblyFactory: AssemblyFactoryProtocol) {
        self.factory = assemblyFactory
        self.serviceFactory = serviceFactory
        self.mainStoryboard = mainStoryboard
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = FaqVC()
        let presenter = FaqPresenterImpl()
        let interactor = FaqInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = FaqRouterImpl.init(factory: self.factory, viewController: vc)
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
