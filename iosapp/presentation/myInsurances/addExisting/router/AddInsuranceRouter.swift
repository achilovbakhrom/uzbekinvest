//
//  AddInsuranceRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol AddInsuranceRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openAddExistingInsurancePage()
    func goBack()
    func goToMainPage()
    func openInsurancePageFromSwitcher()
    func openInstructionPageFromSwitcher()
    func openInstruction()
}

class AddInsuranceRouterImpl: AddInsuranceRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    var presenter: BasePresenter?
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openAddExistingInsurancePage() {
        let vc = AddingInsuranceVC()
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        let vcs = self.viewController?.navigationController?.viewControllers ?? []
        var pinflVCFound = false
        var instructionFound = false
        var insuranceFound = false
        vcs.forEach { vc in
            if vc is PinflVC {
                pinflVCFound = true
            }
            if vc is AddingInstructionVC {
                instructionFound = true
            }
            if vc is AddingInsuranceVC {
                insuranceFound = true
            }
        }
        if !pinflVCFound {
            self.viewController?.setTabBarHidden(false)
        }
        
        if instructionFound || insuranceFound {
            let tempVCS = self.viewController?.navigationController?.viewControllers ?? []
            let vc = tempVCS[tempVCS.count - 2]
            self.viewController?.navigationController?.popViewController(animated: true)
            self.viewController = vc
        } else {
            self.viewController?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func goToMainPage() {
        let vcs = self.viewController?.navigationController?.viewControllers ?? []
        var pinflVCFound = false
        vcs.forEach { vc in
            if vc is PinflVC {
                pinflVCFound = true
            }
        }
        
        if pinflVCFound {
            let a = self.viewController?.navigationController?.viewControllers ?? []
            var finalVcs = [UIViewController]()
            for i in (0..<a.count-1) {
                finalVcs.append(a[i])
                if a[i] is PinflVC {
                    break
                }
            }
            self.viewController?.navigationController?.setViewControllers(finalVcs, animated: true)
        } else {
            if vcs.count > 0 {
                let vc = vcs[0]
                var finalVcs = [UIViewController]()
                finalVcs.append(vc)
    //            self.viewController?.setTabBarHidden(false)
                self.viewController?.navigationController?.setViewControllers(finalVcs, animated: true)
            }
        }
        
        
    }
    
    func openInstructionPageFromSwitcher() {
        let vcs = self.viewController?.navigationController?.viewControllers ?? []
        var finals = vcs.filter { !($0 is SwitcherVC) }         
        let vc = AddingInstructionVC()
        vc.presenter = presenter
        presenter?.view = vc
        finals.append(vc)
        self.viewController?.navigationController?.setViewControllers(finals, animated: false)
        self.viewController = vc
    }
    
    func openInsurancePageFromSwitcher() {
        let vcs = self.viewController?.navigationController?.viewControllers ?? []
        var finals = vcs.filter { !($0 is SwitcherVC) }        
        let vc = AddingInsuranceVC()
        vc.presenter = presenter
        presenter?.view = vc
        finals.append(vc)
        self.viewController?.navigationController?.setViewControllers(finals, animated: false)
        self.viewController = vc
    }
    
    func openInstruction() {
        let vc = AddingInstructionVC()
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
