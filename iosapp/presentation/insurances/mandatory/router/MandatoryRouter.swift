//
//  MandatoryRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MandatoryRouter  {
    init(viewController: UIViewController, presenter: BasePresenter, factory: AssemblyFactoryProtocol)
    func openMandatory1()
    func openMandatory2()
    func openMandatoryConfirmVC()
    func openFinalVC()
}

class MandatoryRouterImpl: BaseInsuranceRouter, MandatoryRouter {
    
    private lazy var mainStoryBoard = self.factory?.storyboardModule.main
    
    required init(viewController: UIViewController, presenter: BasePresenter, factory: AssemblyFactoryProtocol) {
        super.init()
        self.viewController = viewController
        self.presenter = presenter
        self.factory = factory
    }
    
    func openMandatory1() {
        let vc = mainStoryBoard?.instantiateViewController(withIdentifier: "Mandatory1VC") as! Mandatory1VC
        self.presenter?.view = vc
        vc.presenter = self.presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMandatory2() {
        let vc = mainStoryBoard?.instantiateViewController(withIdentifier: "Mandatory2VC") as! Mandatory2VC
        self.presenter?.view = vc
        vc.presenter = self.presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMandatoryConfirmVC() {
        let vc = mainStoryBoard?.instantiateViewController(withIdentifier: "MandatoryConfirmVC") as! MandatoryConfirmVC
        self.presenter?.view = vc
        vc.presenter = self.presenter
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
        
    
}
