//
//  MyDocumentsAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MyDocumentsAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var factory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class MyDocumentsAssemblyImpl: MyDocumentsAssembly {
    var mainStoryboard: UIStoryboard
    var factory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = MyDocumentsVC()
        let presenter = MyDocumentsPresenterImpl()
        let router = MyDocumentsRouterImpl(viewController: vc)
        let interactor = MyDocumentsInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
}
