//
//  RegistrationAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/15/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationAssembly: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class RegistrationAssemblyImpl: RegistrationAssembly {
    
    var serviceFactory: ServiceFactoryProtocol
    var mainStoryboard: UIStoryboard
    var assemblyFactory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.assemblyFactory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "Registration1VC") as! Registration1VC
        let presenter = RegistrationPresenterImpl()
        presenter.view = vc
        let interactor = RegistrationInteractorImpl(serviceFactory: self.serviceFactory)
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router = RegistrationRouterImpl(factory: assemblyFactory, vc: vc, presenter: presenter)
        presenter.router = router
        vc.presenter = presenter
        return vc
    }
}
