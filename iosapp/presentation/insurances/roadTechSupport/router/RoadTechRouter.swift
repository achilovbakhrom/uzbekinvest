//
//  RoadTechRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol RoadTechRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openTechRoad1VC()
    func openTechRoadConfirmVC()
    func goBack()
    func openFinalVC()
}

class RoadTechRouterImpl: BaseInsuranceRouter, RoadTechRouter {
    
    
    private lazy var mainStoryboard = self.factory?.storyboardModule.main
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController,  presenter: BasePresenter) {
        super.init()
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func openTechRoad1VC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "RoadTechSupport1VC") as! RoadTechSupport1VC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTechRoadConfirmVC() {
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "RoadTechSupportConfirmVC") as! RoadTechSupportConfirmVC
        vc.presenter = self.presenter
        self.presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
