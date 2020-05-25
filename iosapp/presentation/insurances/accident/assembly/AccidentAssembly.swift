//
//  AccidentAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol AccidentAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class AccidentAssemblyImpl: AccidentAssembly {
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.storyboard = storyboard
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "AccidentVC") as! AccidentVC
        let presenter = AccidentPresenterImpl()
        let router = AccidentRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        let interactor = AccidentInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
    
}
