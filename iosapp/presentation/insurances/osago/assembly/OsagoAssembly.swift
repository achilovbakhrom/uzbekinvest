//
//  OsagoAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol OsagoAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class OsagoAssemblyImpl: OsagoAssembly {
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "OsagoVC") as! OsagoVC
        let presenter = OsagoPresenterImpl()
        vc.presenter = presenter
        let interactor = OsagoInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = OsagoRouterImpl(factory: assemblyFactory, vc: vc, presenter: presenter)
        presenter.interactor = interactor
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        return vc
    }
    
}
