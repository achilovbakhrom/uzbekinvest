//
//  RegistrationPhoneAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol LoginAssemblyProtocol: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    var factory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class LoginAssembly: LoginAssemblyProtocol {
    
    var mainStoryboard: UIStoryboard
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
    }
    
    
    
    func assembleViewController() -> UIViewController? {
        let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let router = LoginRouter(factory: self.factory, viewController: vc)
        let interactor = LoginInteractor(validator: self.serviceFactory.validator, networkManager: serviceFactory.networkManager, storage: serviceFactory.storage)        
        router.viewController = vc
        let presenter = LoginPresenter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        return vc
    }
    
    
}
