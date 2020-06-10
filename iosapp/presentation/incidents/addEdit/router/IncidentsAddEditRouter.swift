//
//  IncidentsAddEditRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsAddEditRouter: BaseRouter {
    init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter)
    func goBack()
    func openLoginVC(phone: String)
    func openFilesVC()
    func openCommentVC()
    func openAndUpdateIncidents()
    func openReasonVC()
}

class IncidentsAddEditRouterImpl: IncidentsAddEditRouter {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    var presenter: BasePresenter
    required init(factory: AssemblyFactoryProtocol, viewController: UIViewController, presenter: BasePresenter) {
        self.factory = factory
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func goBack() {
        let count = self.viewController?.navigationController?.viewControllers.count ?? 0;
        if (count >= 2) {
            let vc = self.viewController?.navigationController?.viewControllers[count-2] as? BaseViewImpl
            vc?.presenter = presenter
            presenter.view = vc
            
        }
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openFilesVC() {
        let vc = IncidentFilesVC()
        vc.presenter = self.presenter
        self.presenter.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openCommentVC() {
        let vc = CommentsVC()
        vc.presenter = self.presenter
        self.presenter.view = vc
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAndUpdateIncidents() {
        let vc = self.viewController?.navigationController?.viewControllers[0] as! IncidentViewController
        vc.updateList()
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func openLoginVC(phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.factory?.confirmModule.assembleViewController() as! ConfirmVC
        vc.phone = phone
        let navigation = UINavigationController(rootViewController: vc)
        appDelegate.window!.rootViewController = navigation
    }
    
    func openReasonVC() {
        let vc = ReasonVC()
        vc.presenter = self.presenter
        self.presenter.view = vc        
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
