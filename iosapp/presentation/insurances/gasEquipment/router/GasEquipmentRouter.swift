//
//  GasEquipmentRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/6/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


protocol GasEquipmentRouter {
    init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func openGasEquipment1VC()
    func openGasEquipment2VC()
    func openGasEquipmentConfirmVC()
    func goBack()
    func openFinalVC()
}

class GasEquipmentRouterImpl: BaseInsuranceRouter, GasEquipmentRouter {
    
    private lazy var mainStoryboard = self.factory?.storyboardModule.main
    
    required init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        super.init()
        self.factory = assemblyFactory
        self.viewController = viewController
        self.presenter = presenter
    }
    func openGasEquipment1VC() {
        let vc = self.mainStoryboard?.instantiateViewController(withIdentifier: "GasEquipment1VC") as! GasEquipment1VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGasEquipment2VC() {
        let vc = self.mainStoryboard?.instantiateViewController(withIdentifier: "GasEquipment2VC") as! GasEquipment2VC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGasEquipmentConfirmVC() {
        let vc = self.mainStoryboard?.instantiateViewController(withIdentifier: "GasEquipmentConfirmVC") as! GasEquipmentConfirmVC
        vc.presenter = presenter
        presenter?.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
