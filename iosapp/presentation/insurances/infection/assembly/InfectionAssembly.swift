//
//  InfectionAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol InfectionAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class InfectionAssemblyImpl: InfectionAssembly {
    
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "InfectionVC") as! InfectionVC
        let presenter = InfectionPresenterImpl()
        let interactor = InfectionInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = InfectionRouterImpl(assemblyFactory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
