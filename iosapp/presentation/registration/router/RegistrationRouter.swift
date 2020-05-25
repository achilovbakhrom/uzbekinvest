//
//  RegistrationRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/15/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationRouter: BaseRouter {
    var presenter: BasePresenter? { get set }
    init(factory: AssemblyFactoryProtocol, vc: UIViewController, presenter: BasePresenter)
    func openRegistration1()
    func goBack()
    func openRegistration2()
    func openRegistration3()
    func openOfferVC()
    func openDashboard()
}

class RegistrationRouterImpl: RegistrationRouter {
    
    var factory: AssemblyFactoryProtocol? = nil
    var viewController: UIViewController? = nil
    var presenter: BasePresenter? = nil
    
    required init(factory: AssemblyFactoryProtocol, vc: UIViewController, presenter: BasePresenter) {
        self.factory = factory
        self.viewController = vc
        self.presenter = presenter
    }
    
    func openRegistration1() {
        let registration1 = factory?.storyboardModule.main.instantiateViewController(withIdentifier: "Registration1VC") as! Registration1VC
        self.presenter?.view = registration1
        registration1.presenter = self.presenter
        self.viewController?.navigationController?.setViewControllers([registration1], animated: true)
    }
    
    func goBack() {
        let vcs = self.viewController?.navigationController?.viewControllers ?? []
        if vcs.count >= 2 {
            self.presenter?.view = vcs[vcs.count - 2]
        }
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openRegistration2() {
        let registration2 = factory?.storyboardModule.main.instantiateViewController(withIdentifier: "Registration2VC") as! Registration2VC
        self.presenter?.view = registration2
        registration2.presenter = self.presenter
        self.viewController?.navigationController?.pushViewController(registration2, animated: true)
    }
    
    func openRegistration3() {
        let registration3 = factory?.storyboardModule.main.instantiateViewController(withIdentifier: "Registration3VC") as! Registration3VC
        self.presenter?.view = registration3
        registration3.presenter = self.presenter
        self.viewController?.navigationController?.pushViewController(registration3, animated: true)
    }
    
    func openOfferVC() {
        let offerVC = factory?.storyboardModule.main.instantiateViewController(withIdentifier: "OfferVC") as! OfferVC
        self.presenter?.view = offerVC
        offerVC.presenter = self.presenter
        self.viewController?.navigationController?.pushViewController(offerVC, animated: true)
    }
    
    func openDashboard() {
        let vc = self.factory?.storyboardModule.main.instantiateViewController(withIdentifier: "MainPage") as! UITabBarController
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
