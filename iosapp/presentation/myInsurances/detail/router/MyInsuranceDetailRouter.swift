//
//  MyInsuranceDetailRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MyInsuranceDetailRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
    func goBack()
    func openLoginVC(phone: String)
    func openIncidents()
}

class MyInsuranceDetailRouterImpl: MyInsuranceDetailRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = factory
        self.viewController = viewController
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
    func openIncidents() {
        self.viewController?.tabBarController?.selectedIndex = 1
        let vc = self.viewController?.tabBarController?.viewControllers?[1]
        vc?.navigationController?.pushViewController(factory?.incidentsDetailModule.assembleViewController() ?? UIViewController(), animated: true)
    }
    
}
