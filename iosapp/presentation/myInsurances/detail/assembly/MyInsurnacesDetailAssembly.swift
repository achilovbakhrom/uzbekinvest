//
//  MyInsurnacesDetailAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


class MyInsurnacesDetailAssembly: BaseAssemblyProtocol {
    
    var serviceFactory: ServiceFactoryProtocol
    var assemblyFactory: AssemblyFactoryProtocol
    
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactoryProtocol) {
        self.serviceFactory = serviceFactory
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = MyInsurancesDetailVC()
        let presenter = MyInsurancesDetailPresenterImpl()
        let router = MyInsuranceDetailRouterImpl(factory: self.assemblyFactory, viewController: vc)
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
}
