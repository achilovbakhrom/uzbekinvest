//
//  NotificationRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol NotificationRouter: BaseRouter {
    func goBack()
    func openLoginVC(phone: String)
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
}


class NotificationRouterImpl: NotificationRouter {
    
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
    
}
