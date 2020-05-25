//
//  MandatoryAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MandatoryAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class MandatoryAssemblyImpl: MandatoryAssembly {
    
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = self.storyboard.instantiateViewController(withIdentifier: "MandatoryVC") as! MandatoryVC
        let presenter = MandatoryPresenterImpl()
        presenter.view = vc
        vc.presenter = presenter
        let interactor = MandatoryInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        let router = MandatoryRouterImpl(viewController: vc, presenter: presenter, factory: assemblyFactory)
        presenter.router = router
        router.presenter = presenter
        return vc
    }
    
}
