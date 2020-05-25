//
//  OrderCheckRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol OrderCheckRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openMainPage()
    func openCheckOrder2VC()
    func goBack()
    func openLoginVC(phone: String)
}

class OrderCheckRouterImpl: OrderCheckRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    var presenter: BasePresenter?
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openMainPage() {
        guard let vc = self.viewController?.navigationController?.viewControllers[0] else { return }
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func openCheckOrder2VC() {
        let vc = OrderCheck2VC()
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        if (self.viewController?.navigationController?.viewControllers.count ?? 0) == 3 {
            let vc = self.viewController?.navigationController?.viewControllers[1] as! OrderCheck1VC
            vc.presenter = self.presenter
            presenter?.view = vc
        }
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
