//
//  LuggageAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol LuggageAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class LuggageAssemblyImpl: LuggageAssembly {
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.storyboard = storyboard
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "LuggageVC") as! LuggageVC
        let presenter = LuggagePresenterImpl()
        let router = LuggageRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        let interactor = LuggageInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
    
}

