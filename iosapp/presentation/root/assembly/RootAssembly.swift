//
//  RootAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class RootAssembly: RootAssemblyProtocol {
    
    var serviceFactory: ServiceFactoryProtocol
    var mainStoryboard: UIStoryboard
    var factory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory;
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "RootVC") as? RootVC
        let presenter = RootPresenter()
        let router = RootRouter(viewController: vc, factory: self.factory)
        let interactor = RootInteractor(tokenFactory: serviceFactory.tokenFactory, storage: serviceFactory.storage)
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        vc?.presenter = presenter
        return vc;
    }
    
}
