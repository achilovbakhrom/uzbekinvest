//
//  GasEquipmentAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol GasEquipmentAssembly: BaseAssemblyProtocol {
    var storyboard: UIStoryboard { get set }
    var assemblyFactory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class GasEquipmentAssemblyImpl: GasEquipmentAssembly {
    var storyboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.storyboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = storyboard.instantiateViewController(withIdentifier: "GasEquipmentVC") as! GasEquipmentVC
        let presenter = GasEquipmentPresenterImpl()
        let interactor = GasEquipmentInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        let router = GasEquipmentRouterImpl(assemblyFactory: self.assemblyFactory, viewController: vc, presenter: presenter)
        presenter.router = router
        presenter.interactor = interactor
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
    
}
