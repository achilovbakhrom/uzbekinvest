//
//  KaskoRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol KaskoRouter {
    
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BaseInsurancePresenter)
    
    func openKasko1VC()
    func openKasko2VC()
    func openKaskoConfirmVC()
    func openFinalVC()
    func goBack()
}

class KaskoRouterImpl: BaseInsuranceRouter, KaskoRouter {
    
    private lazy var mainStoryboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BaseInsurancePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openKasko1VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Kasko1VC") as! Kasko1VC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openKasko2VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Kasko2VC") as! Kasko2VC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openKaskoConfirmVC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "KaskoConfirmVC") as! KaskoConfirmVC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }    
}
