//
//  Registration1Assembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol Registration1AssemblyProtocol: BaseAssemblyProtocol {
    var factory: AssemblyFactoryProtocol {get set}
    init(factory: AssemblyFactoryProtocol, serviceFactory: ServiceFactoryProtocol)
}

class Registration1Assembly: Registration1AssemblyProtocol {
    var factory: AssemblyFactoryProtocol
    
    var serviceFactory: ServiceFactoryProtocol
    
    required init(factory: AssemblyFactoryProtocol, serviceFactory: ServiceFactoryProtocol) {
        self.factory = factory
        self.serviceFactory = serviceFactory
    }
    
    
    
    func assembleViewController() -> UIViewController? {
        let registration1VC = self.factory.storyboardModule.main.instantiateViewController(withIdentifier: "Registration1vC") as! Registration1VC
        let interactor = Registration1Interactor(networkManager: serviceFactory.networkManager)
        let router = Registration1Router(factory: self.factory, vc: registration1VC)
        let presenter = Registration1Presenter()
        presenter.router = router
        presenter.view = registration1VC
        presenter.interactor = interactor
        interactor.presenter = presenter
        registration1VC.presenter = presenter        
        return registration1VC
    }
    
    
}
