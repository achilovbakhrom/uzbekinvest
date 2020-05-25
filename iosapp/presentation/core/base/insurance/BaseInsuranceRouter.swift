//
//  BaseInsuranceRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class BaseInsuranceRouter: BaseRouter {
    
    var viewController: UIViewController?
    var factory: AssemblyFactoryProtocol? = nil
    var presenter: BasePresenter? = nil
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
    func openFinalVC(){
        let vc = BaseInsuranceConfirmVC()
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMyInsurances() {
        let vc = self.viewController?.navigationController?.viewControllers[0] ?? UIViewController()
        let tabBarVcs = vc.navigationController?.tabBarController?.viewControllers ?? []
        if tabBarVcs.count > 2 {
            let nc = tabBarVcs[2] as! UINavigationController
            let myInsuranceVC = nc.viewControllers[0] as? MyInsuranceVC
            DispatchQueue.main.async {
                myInsuranceVC?.reloadList()
                vc.navigationController?.tabBarController?.selectedIndex = 2
                self.viewController?.setTabBarHidden(false)
            }
        }
        vc.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func goBack() {
        let vc = getPrevVC() as! BaseViewImpl
        self.presenter?.view = vc
        vc.presenter = self.presenter
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    
}

