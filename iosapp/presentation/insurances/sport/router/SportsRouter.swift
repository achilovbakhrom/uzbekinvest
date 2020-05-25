//
//  SportsRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol SportsRouter {
    init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openSport1VC()
    func openSport2VC()
    func openSport3VC()
    func openSport4VC()
    func openSportConfirmVC()
    func goBack()
    func openFinalVC()
}

class SportsRouterImpl: BaseInsuranceRouter, SportsRouter {
    
    private lazy var mainStoryboard = self.factory?.storyboardModule.main
    required init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = assemblyFactory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openSport1VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Sport1VC") as! Sport1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSport2VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Sport2VC") as! Sport2VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSport3VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Sport3VC") as! Sport3VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSport4VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "Sport4VC") as! Sport4VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSportConfirmVC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "SportConfirmVC") as! SportConfirmVC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
