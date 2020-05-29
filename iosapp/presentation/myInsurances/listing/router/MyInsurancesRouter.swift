//
//  MyInsurancesRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MyInsurancesRouter: BaseRouter {
    
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openLoginVC(phone: String)
    func openMyInsuranceDetail(myInsurance: MyInsurance, property: [String: String])
    func openAddInsuranceInstructionPage()
    func openAddInsurancePage()
    func goBack()
    func openAddMyInsuranceVC()
    func openInsuranceListVC()
}

class MyInsrancesRouterImpl: MyInsurancesRouter {
    
    var factory: AssemblyFactoryProtocol?
    
    var viewController: UIViewController?
    var presenter: BasePresenter?
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
    func openMyInsuranceDetail(myInsurance: MyInsurance, property: [String: String]) {
        let vc = self.factory?.myInsuranceDetailModule.assembleViewController() as! MyInsurancesDetailVC
        vc.myInsurance = myInsurance
        vc.properties = property
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAddInsuranceInstructionPage() {
        let vc = self.factory?.addInsuranceModule.assembleViewController()
        self.viewController?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func openAddInsurancePage() {
        var vcs = self.viewController?.navigationController?.viewControllers
        let vc = self.factory?.addInsuranceModule.assembleViewController() as! AddingInstructionVC
        vcs?.append(vc)
        let presenter = vc.presenter
        let addVC = AddingInsuranceVC()
        addVC.presenter = presenter
        presenter?.view = addVC
        vcs?.append(addVC)
        self.viewController?.navigationController?.setViewControllers(vcs!, animated: true)
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
        
    func openAddMyInsuranceVC() {
        let vc = AddMyInsuranceVC()
        vc.presenter = presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInsuranceListVC() {
        let vc = self.factory?.insuranceListModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
