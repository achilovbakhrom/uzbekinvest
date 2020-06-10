//
//  IncidentsDetailRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//
import UIKit

protocol IncidentsDetailRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
    func goBack()
    func openLoginVC(phone: String)
    func openAddEditVC(orderId: Int, productCode: String, isOffline: Int)
}

class IncidentsDetailRouterImpl: IncidentsDetailRouter {
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
    
    func openAddEditVC(orderId: Int, productCode: String, isOffline: Int) {
        let vc = (self.factory?.incidentsAddEditModule.assembleViewController() ?? UIViewController()) as! LocationVC
        vc.orderId = orderId
        vc.productCode = productCode
        vc.isOffline = isOffline
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
