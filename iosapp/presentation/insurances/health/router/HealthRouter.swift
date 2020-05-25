//
//  HealthRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol HealthRouter {
    func openHealth1VC()
    func openHealth2VC()
    func openHealthConfirmVC()
    func goBack()
    func openFinalVC()
    init(factory: AssemblyFactoryProtocol, vc: UIViewController, presenter: BasePresenter)
}

class HealthRouterImpl: BaseInsuranceRouter, HealthRouter {
    
    private lazy var storyboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, vc: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = vc
        self.presenter = presenter
    }
    
    
    func openHealth1VC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Health1VC") as! Health1VC
        self.presenter?.view = vc
        vc.presenter = presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHealth2VC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Health2VC") as! Health2VC
        self.presenter?.view = vc
        vc.presenter = presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHealthConfirmVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HealthConfirmVC") as! HealthConfirmVC
        self.presenter?.view = vc
        vc.presenter = presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
