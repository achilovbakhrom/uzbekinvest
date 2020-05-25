//
//  MobilePhoneAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MobilePhoneAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class MobilePhoneAssemblyImpl: MobilePhoneAssembly {
    
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
        
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "MobilePhoneVC") as! MobilePhoneVC
        let presenter = MobilePhonePresenterImpl()
        let interactor = MobilePhoneInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = MobilePhoneRouterImpl(assembleFactory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
}
