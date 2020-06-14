//
//  MainProfileRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MainProfileRouter: BaseRouter {
    init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController)
    func openOfficesVC()
    func openLoginVC(phone: String)
    func openMyDocs()
    func openSettings()
    func openFaq()
    func openAboutUs()
}


class MainProfileRouterImpl: MainProfileRouter {

    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(assemblyFactory: AssemblyFactoryProtocol, viewController: UIViewController) {
        self.factory = assemblyFactory
        self.viewController = viewController
    }
    
    func openOfficesVC() {
        let vc = self.factory?.officesModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
    func openMyDocs() {
        let vc = self.factory?.myDocumentsModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSettings() {
        let vc = self.factory?.settingsModule.assembleViewController()
        self.viewController?.navigationController?.pushViewController(vc!, animated: true)
    }
    func openFaq() {
        let vc = self.factory?.faqModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAboutUs() {
        let vc = AboutUsVC()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
