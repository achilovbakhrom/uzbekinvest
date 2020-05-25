//
//  OsagoRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol OsagoRouter {
    
    func openOsago1VC()
    func openOsago2VC()
    func openOsago3VC()
    func openOsago4VC()
    func openOsagoConfirmVC()
    func openOsagoFinalVC()
    func goBack()
    init(factory: AssemblyFactoryProtocol, vc: UIViewController, presenter: BasePresenter)
}

class OsagoRouterImpl: BaseInsuranceRouter, OsagoRouter {
    
    
    private lazy var mainStoryboard: UIStoryboard? = {
        return self.factory?.storyboardModule.main
    }()
    
    required init(factory: AssemblyFactoryProtocol, vc: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = vc
        self.presenter = presenter
    }
    
    func openOsago1VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Osago1VC") as! Osago1VC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openOsago2VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Osago2VC") as! Osago2VC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openOsago3VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Osage3VC") as! Osage3VC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openOsago4VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Osago4VC") as! Osago4VC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openOsagoConfirmVC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "OsagoConfirm") as! OsagoConfirm
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openOsagoFinalVC() {
        let vc = BaseInsuranceConfirmVC()
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
