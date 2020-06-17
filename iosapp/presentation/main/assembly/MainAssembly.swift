//
//  MainAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/22/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MainAssembly: BaseAssemblyProtocol {
    var serviceFactory: ServiceFactoryProtocol
    var assemblyFactory: AssemblyFactoryProtocol
    
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactoryProtocol) {
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = MainViewController(factory: assemblyFactory)
        let presenter = MainPresenterImpl()
        let interactor = MainInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.view  = vc
        vc.presenter = presenter
        vc.factory = self.assemblyFactory
        return vc
    }
}
