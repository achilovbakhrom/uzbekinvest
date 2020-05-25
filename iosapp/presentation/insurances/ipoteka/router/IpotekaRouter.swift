//
//  IpotekaInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol IpotekaRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openIpoteka1()
    func openIpotekaConfirmVC()
    func goBack()
    func openFinalVC()
}

class IpotekaRouterImpl: BaseInsuranceRouter, IpotekaRouter {
    
        
    private lazy var storyboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openIpoteka1() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Ipoteka1VC") as! Ipoteka1VC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openIpotekaConfirmVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IpotekaConfirmVC") as! IpotekaConfirmVC
        vc.presenter = self.presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
