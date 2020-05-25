//
//  MyDocumentsRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


protocol MyDocumentsRouter: BaseRouter {
    
    init(viewController: UIViewController)
    func goBack()
    func openLoginVC(phone: String)
    
}


class MyDocumentsRouterImpl: MyDocumentsRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
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
