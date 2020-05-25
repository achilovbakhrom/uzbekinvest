//
//  GasRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol GasRouter {
    
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openGas1VC()
    func openGas2VC()
    func openGas3VC()
    func openGasConfirmVC()
    
    func goBack()
    func openFinalVC()
}

class GasRouterImpl: BaseInsuranceRouter, GasRouter {
    
    private lazy var storyboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openGas1VC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Gas1VC") as! Gas1VC
        vc.presenter = presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGas2VC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Gas2VC") as! Gas2VC
        vc.presenter = presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGas3VC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Gas3VC") as! Gas3VC
        vc.presenter = presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGasConfirmVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GasConfirmVC") as! GasConfirmVC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
