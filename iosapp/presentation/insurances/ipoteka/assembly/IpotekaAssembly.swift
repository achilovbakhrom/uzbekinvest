//
//  IpotekaAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol IpotekaAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class IpotekaAssemblyImpl: IpotekaAssembly {
    var assemblyFactory: AssemblyFactory
    
    var serviceFactory: ServiceFactoryProtocol
    var storyboard: UIStoryboard
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "IpotekaVC") as? IpotekaVC
        let presenter = IpotekaPresenterImpl()
        let interactor = IpotekaInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = IpotekaRouterImpl(factory: self.assemblyFactory, viewController: vc!, presenter: presenter)
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        vc?.presenter = presenter
        return vc
    }
    
    
}
