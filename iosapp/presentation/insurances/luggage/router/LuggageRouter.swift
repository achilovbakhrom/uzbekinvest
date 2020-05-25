//
//  LuggageRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol LuggageRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openLuggage1VC()
    func openLuggage2VC()
    func openLuggageConfirmVC()
    func goBack()
    func openFinalVC()
}

class LuggageRouterImpl: BaseInsuranceRouter, LuggageRouter {
    
    private lazy var storyboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openLuggage1VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Luggage1VC") as! Luggage1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLuggage2VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Luggage2VC") as! Luggage2VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLuggageConfirmVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LuggageConfirmVC") as! LuggageConfirmVC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
