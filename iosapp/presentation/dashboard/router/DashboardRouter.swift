//
//  DashboardRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardRouter: BaseRouter {
    
    func openOsago(product: Product)
    func openMandatory(product: Product)
    func openHome(product: Product)
    func openKasko(product: Product)
    func openHealth(product: Product)
    func openIpoteka(product: Product)
    func openAccident(product: Product)
    func openSport(product: Product)
    func openRoadTech(product: Product)
    func openGasHome(product: Product)
    func openGasAuto(product: Product)
    func openInfection(product: Product)
    func openMobilePhone(product: Product)
    func openLuggage(product: Product)
    func openTravel(product: Product)
    func openCheckOrderVC()
    func openIncidentsVC()
    func openSupportVC()
    func openNotifications()
    func openInsuranceWeb()
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController)
}

class DashboardRouterImpl: DashboardRouter {
    
    var factory: AssemblyFactoryProtocol?
    
    var viewController: UIViewController?
    
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = factory
        self.viewController = viewController
    }
    
    func openOsago(product: Product) {
        let vc = factory?.osagoModule.assembleViewController() ?? UIViewController()
        (vc as? OsagoVC)?.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)        
    }
    func openMandatory(product: Product) {
        let vc = (factory?.pledgedTransportModule.assembleViewController() ?? UIViewController()) as! MandatoryVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHome(product: Product) {
        let vc = (factory?.homeModule.assembleViewController() ?? UIViewController()) as! HomeVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openKasko(product: Product) {
        let vc = (factory?.kaskoModule.assembleViewController() ?? UIViewController()) as! KaskoVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHealth(product: Product) {
        let vc = (factory?.healthModule.assembleViewController() ?? UIViewController()) as! HealthVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openIpoteka(product: Product) {
        let vc = (factory?.pledgedPropertyModule.assembleViewController() ?? UIViewController()) as! IpotekaVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAccident(product: Product) {
        let vc = (factory?.accidentModule.assembleViewController() ?? UIViewController()) as! AccidentVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSport(product: Product) {
        let vc = (factory?.sportModule.assembleViewController() ?? UIViewController()) as! SportVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openRoadTech(product: Product) {
        let vc = (factory?.roadTechModule.assembleViewController() ?? UIViewController()) as! RoadTechSupportVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGasHome(product: Product) {
        let vc = (factory?.gasHomeModule.assembleViewController() ?? UIViewController()) as! GasVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openGasAuto(product: Product) {
        let vc = (factory?.gasAutoModule.assembleViewController() ?? UIViewController()) as! GasEquipmentVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInfection(product: Product) {
        let vc = (factory?.infectionModule.assembleViewController() ?? UIViewController()) as! InfectionVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMobilePhone(product: Product) {
        let vc = (factory?.mobilePhoneModule.assembleViewController() ?? UIViewController()) as! MobilePhoneVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLuggage(product: Product) {
        let vc = (factory?.luggageModule.assembleViewController() ?? UIViewController()) as! LuggageVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openCheckOrderVC() {
        let vc = factory?.orderCheckModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openTravel(product: Product) {
        let vc = (factory?.travelModule.assembleViewController() ?? UIViewController()) as! TravelVC
        vc.product = product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openIncidentsVC() {
        self.viewController?.tabBarController?.selectedIndex = 1
        let vc = self.viewController?.tabBarController?.viewControllers?[1]
        vc?.navigationController?.pushViewController(factory?.incidentsDetailModule.assembleViewController() ?? UIViewController(), animated: true)
    }
    
    func openSupportVC() {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func openNotifications() {
        let vc = self.factory?.notificationModule.assembleViewController()
        self.viewController?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func openInsuranceWeb() {
        guard let url = URL(string: "https://www.insurance.uz") else { return }
        UIApplication.shared.open(url)
    }
}
