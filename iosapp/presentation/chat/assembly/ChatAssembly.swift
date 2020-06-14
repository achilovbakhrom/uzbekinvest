//
//  ChatAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol ChatAssembly: BaseAssemblyProtocol {
    var factory: AssemblyFactory { get set }
    init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory)
}

class ChatAssemblyImpl: ChatAssembly {
    
    var factory: AssemblyFactory
    var serviceFactory: ServiceFactoryProtocol
    
    required init(serviceFactory: ServiceFactoryProtocol, assemblyFactory: AssemblyFactory) {
        self.factory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let vc = ChatVC()
        let presenter = ChatPresenterImpl()        
        let interactor = ChatInteractorImpl(serviceFactory: self.serviceFactory, presenter: presenter)
        presenter.interactor = interactor
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
