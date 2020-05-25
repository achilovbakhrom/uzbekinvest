//
//  SettingsRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol SettingsRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, basePresenter: BasePresenter)
    func goBack()
    func openEditProfileVC()
    func openAddByPinfl()
    func openPinflListVC()
    func openAddInsuranceInstructionPage()
    func openAddInsurancePage()
    func openLoginVC(phone: String)
}

class SettingsRouterImpl: SettingsRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    var presenter: BasePresenter
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, basePresenter: BasePresenter) {
        self.factory = factory
        self.viewController = viewController
        self.presenter = basePresenter
    }
    
    func goBack() {
        if (self.viewController?.navigationController?.viewControllers.count ?? 0) > 2 {
            let count = self.viewController?.navigationController?.viewControllers.count ?? 0
            if (count > 0) {
                let vc = self.viewController?.navigationController?.viewControllers[count-2] as! SettingsVC
                self.presenter.view = vc
            }
        }
        self
            .viewController?
            .navigationController?
            .popViewController(animated: true)
    }
    
    func openEditProfileVC() {
        let editProfileVC = EditProfileVC()
        editProfileVC.presenter = self.presenter
        self.presenter.view = editProfileVC
        self
            .viewController?
            .navigationController?
            .pushViewController(editProfileVC, animated: true)
        
    }
    
    func openAddByPinfl() {
        let vc = self.factory?.addInsuranceModule.assembleViewController()
        self.viewController?.navigationController?.pushViewController(vc!, animated: true)
    }
        
    func openPinflListVC() {
        let vc = PinflVC()
        vc.presenter = presenter
        presenter.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAddInsuranceInstructionPage() {
        let vc = self.factory?.addInsuranceModule.assembleViewController() as! SwitcherVC
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAddInsurancePage() {
        var vcs = self.viewController?.navigationController?.viewControllers
        let vc = self.factory?.addInsuranceModule.assembleViewController() as! SwitcherVC
        vcs?.append(vc)
        self.viewController?.navigationController?.setViewControllers(vcs!, animated: true)
    }
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
}




