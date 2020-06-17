//
//  MainViewController.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/22/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    var factory: AssemblyFactoryProtocol?
    var presenter: MainPresenter? = nil
    init(factory: AssemblyFactoryProtocol) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    
    
    var dashboardNavigatonController: UINavigationController!
    var incidentsNavigationController: UINavigationController!
    var myInsuranceNavigationController: UINavigationController!
    var mainProfileNavigationController: UINavigationController!
    
    func initUI() {
        let dashboardVC = factory?.dashboardModule.assembleViewController() ?? UIViewController()
        dashboardVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-home"), selectedImage: UIImage(named: "tab-home-select"))
        
        dashboardNavigatonController = UINavigationController(rootViewController: dashboardVC)
        dashboardNavigatonController.view.backgroundColor = .white
        let incidents = factory?.incidentModule.assembleViewController() ?? UIViewController()
        incidents.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-call"), selectedImage: UIImage(named: "tab-call-selected"))
        
        incidentsNavigationController = UINavigationController(rootViewController: incidents)
        incidentsNavigationController.view.backgroundColor = .white
        incidentsNavigationController.extendedLayoutIncludesOpaqueBars = true
        
        let myInsurancesVC = factory?.myInsurancesModule.assembleViewController() ?? UIViewController()
        
        myInsurancesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-insurance"), selectedImage: UIImage(named: "tab-insurance-selected"))
        myInsuranceNavigationController = UINavigationController(rootViewController: myInsurancesVC)
        myInsuranceNavigationController.view.backgroundColor = .white
        let mainProfileVC = factory?.mainProfileModule.assembleViewController() ?? UIViewController()
        mainProfileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-settings"), selectedImage: UIImage(named: "tab-settings-settings"))
        self.tabBar.tintColor = Colors.primaryGreen
        mainProfileNavigationController = UINavigationController(rootViewController: mainProfileVC)
        mainProfileNavigationController.view.backgroundColor = .white
        self.viewControllers = [dashboardNavigatonController, incidentsNavigationController, myInsuranceNavigationController, mainProfileNavigationController]
    }
    
    func handleLink(link: String, needReload: Bool) {
        if needReload {
            self.initUI()
        }
        
        if link.contains("/products/") {
            if let url = URL(string: link) {
                self.presenter?.getProductById(id: url.lastPathComponent)
            }
        }
        
        if (link.contains("/news")) {
            self.dashboardNavigatonController?.pushViewController(factory?.notificationModule.assembleViewController() ?? UIViewController(), animated: true)
        }

        if (link.hasSuffix("/user/orders")) {
            self.selectedIndex = 2
        } else if (link.contains("/user/orders/")) {
            if let url = URL(string: link) {
                self.presenter?.getInsuranceById(id: url.lastPathComponent)
            }
        }

        if (link.hasSuffix("/user/incidents")) {
            self.selectedIndex = 1
        } else if (link.contains("/user/incidents/")) {
            if let url = URL(string: link) {
                self.presenter?.getIncidentById(id: url.lastPathComponent)
            }
        }
    }
    
}

extension MainViewController {
    func openOsago(product: Product) {
        let vc = factory?.osagoModule.assembleViewController() ?? UIViewController()
        (vc as? OsagoVC)?.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    func openMandatory(product: Product) {
        let vc = (factory?.pledgedTransportModule.assembleViewController() ?? UIViewController()) as! MandatoryVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openHome(product: Product) {
        let vc = (factory?.homeModule.assembleViewController() ?? UIViewController()) as! HomeVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openKasko(product: Product) {
        let vc = (factory?.kaskoModule.assembleViewController() ?? UIViewController()) as! KaskoVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openHealth(product: Product) {
        let vc = (factory?.healthModule.assembleViewController() ?? UIViewController()) as! HealthVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openIpoteka(product: Product) {
        let vc = (factory?.pledgedPropertyModule.assembleViewController() ?? UIViewController()) as! IpotekaVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openAccident(product: Product) {
        let vc = (factory?.accidentModule.assembleViewController() ?? UIViewController()) as! AccidentVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openSport(product: Product) {
        let vc = (factory?.sportModule.assembleViewController() ?? UIViewController()) as! SportVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openRoadTech(product: Product) {
        let vc = (factory?.roadTechModule.assembleViewController() ?? UIViewController()) as! RoadTechSupportVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openGasHome(product: Product) {
        let vc = (factory?.gasHomeModule.assembleViewController() ?? UIViewController()) as! GasVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openGasAuto(product: Product) {
        let vc = (factory?.gasAutoModule.assembleViewController() ?? UIViewController()) as! GasEquipmentVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openInfection(product: Product) {
        let vc = (factory?.infectionModule.assembleViewController() ?? UIViewController()) as! InfectionVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openMobilePhone(product: Product) {
        let vc = (factory?.mobilePhoneModule.assembleViewController() ?? UIViewController()) as! MobilePhoneVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openLuggage(product: Product) {
        let vc = (factory?.luggageModule.assembleViewController() ?? UIViewController()) as! LuggageVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openTravel(product: Product) {
        let vc = (factory?.travelModule.assembleViewController() ?? UIViewController()) as! TravelVC
        vc.product = product
        self.dashboardNavigatonController?.pushViewController(vc, animated: true)
    }
    
    func openMyInsurance(myInsurance: MyInsurance) {
        let vc = factory?.myInsuranceDetailModule.assembleViewController() as? MyInsurancesDetailVC
        vc?.myInsurance = myInsurance
        self.myInsuranceNavigationController?.pushViewController(vc!, animated: true)
        self.selectedIndex = 2
    }
    
    func openIncident(incident: Incident) {
        let vc = factory?.incidentInfoModuule.assembleViewController() as? IncidentsInfoVC
        vc?.incident = incident
        self.myInsuranceNavigationController?.pushViewController(vc!, animated: true)
        self.selectedIndex = 1
    }
}

extension MainViewController: UITabBarControllerDelegate  {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }
        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
    
}

