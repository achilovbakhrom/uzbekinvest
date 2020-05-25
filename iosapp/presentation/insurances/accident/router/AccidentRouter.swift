//
//  AccidentRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol AccidentRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openAccident1VC()
    func openAccidentConfirmVC()
    func goBack()
    func openFinalVC()
}

class AccidentRouterImpl: BaseInsuranceRouter, AccidentRouter {
    
    private lazy var storyboard = self.factory?.storyboardModule.main
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openAccident1VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Accident1VC") as! Accident1VC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAccidentConfirmVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccidentConfirmVC") as! AccidentConfirmVC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
