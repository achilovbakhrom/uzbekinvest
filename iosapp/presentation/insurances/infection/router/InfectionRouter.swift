//
//  InfectionRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol InfectionRouter {
    init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openInfection1VC()
    func openInfection2VC()
    func openInfectionConfirmVC()
    func goBack()
    
    func openFinalVC()
}

class InfectionRouterImpl: BaseInsuranceRouter, InfectionRouter {
    
    private lazy var mainStoryboard = self.factory?.storyboardModule.main
    
    required init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = assemblyFactory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openInfection1VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Infection1VC") as! Infection1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInfection2VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Infection2VC") as! Infection2VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInfectionConfirmVC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "InfectionConfirmVC") as! InfectionConfirmVC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

