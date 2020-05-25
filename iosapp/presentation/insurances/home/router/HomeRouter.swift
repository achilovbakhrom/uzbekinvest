//
//  HomeRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouter {
    init(factory: AssemblyFactoryProtocol, view: UIViewController, presenter: BasePresenter)
    func openHome1VC()
    func openHomeConfirmVC()
    func goBack()
    func openFinalVC()
}

class HomeRouterImpl: BaseInsuranceRouter, HomeRouter {
    
    private lazy var mainStoryboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, view: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = view
        self.presenter = presenter
    }
    
    func openHome1VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Home1VC") as! Home1VC
        vc.presenter = self.presenter
        self.presenter?.view = self.viewController
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHomeConfirmVC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "HomeConfirmVC") as! HomeConfirmVC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
