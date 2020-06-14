//
//  IncidentsListingRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsListingRouter: BaseRouter {
    init(factory: AssemblyFactory, viewController: UIViewController)
    func openDetailPage()
    func openLoginVC(phone: String)
    func openIncidentInfo(incident: Incident)
    func openChatVC()
}

class IncidentsListingRouterImpl: IncidentsListingRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(factory: AssemblyFactory, viewController: UIViewController) {
        self.factory = factory
        self.viewController = viewController
    }
    
    func openIncidentInfo(incident: Incident) {
        let vc = (self.factory?.incidentInfoModuule.assembleViewController() ?? UIViewController()) as! IncidentsInfoVC
        vc.incident = incident
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetailPage() {
        let vc = self.factory?.incidentsDetailModule.assembleViewController() ?? UIViewController()
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
    func openChatVC() {
        let vc = self.factory?.chatModule.assembleViewController() ?? UIViewController()
//        vc.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
