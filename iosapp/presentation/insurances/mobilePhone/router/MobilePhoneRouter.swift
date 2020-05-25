//
//  MobilePhoneRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MobilePhoneRouter {
    init(assembleFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openMobilePhone1VC()
    func openMobilePhoneConfirmVC()
    func goBack()
    func openFinalVC()
}

class MobilePhoneRouterImpl: BaseInsuranceRouter, MobilePhoneRouter {
    
    
    
    private lazy var storyboard = self.factory?.storyboardModule.main
    
    required init(assembleFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = assembleFactory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openMobilePhone1VC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MobilePhone1VC") as! MobilePhone1VC
        presenter?.view = vc
        vc.presenter = presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMobilePhoneConfirmVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MobilePhoneConfirmVC") as! MobilePhoneConfirmVC
        self.presenter?.view = vc
        vc.presenter = presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
