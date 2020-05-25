//
//  KaskoAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol KaskoAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class KaskoAssemblyImpl: KaskoAssembly {
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "KaskoVC") as! KaskoVC
        let presenter = KaskoPresenterImpl()
        let interactor = KaskoInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = KaskoRouterImpl(factory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    
}
