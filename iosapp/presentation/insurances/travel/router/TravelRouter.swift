//
//  TravelRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol TravelRouter {
    func openTravel1VC()
    func openTravel2VC()
    func openTravel3VC()
    func openTravel4VC()
    func openTravel5VC()
    func openTravelConfirm1VC()
    func openTravelConfirm2VC()
    func openFinalVC()
    func goBack()
    func openSelectTypeVC()
    func openTouristsList1VC()
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
}

class TravelRouterImpl: BaseInsuranceRouter, TravelRouter {
    
    private lazy var storyboard = self.factory?.storyboardModule.main
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openTravel1VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Travel1VC") as! Travel1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravel2VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Travel2VC") as! Travel2VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravel3VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Travel3VC") as! Travel3VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravel4VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Travel4VC") as! Travel4VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSelectTypeVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TravelSelectTypeVC") as! TravelSelectTypeVC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravel5VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Travel5VC") as! Travel5VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravelConfirm1VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TravelConfirm1VC") as! TravelConfirm1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTouristsList1VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TouristList1VC") as! TouristList1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravelConfirm2VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TravelConfirm2VC") as! TravelConfirm2VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
