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
        
        
        
        let dashboardVC = factory?.dashboardModule.assembleViewController() ?? UIViewController()
        dashboardVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-home"), selectedImage: UIImage(named: "tab-home-select"))
        
        let dashboardNavigatonController = UINavigationController(rootViewController: dashboardVC)
        dashboardNavigatonController.view.backgroundColor = .white
        let incidents = factory?.incidentModule.assembleViewController() ?? UIViewController()
        incidents.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-call"), selectedImage: UIImage(named: "tab-call-selected"))
        
        let incidentsNavigationController = UINavigationController(rootViewController: incidents)
        incidentsNavigationController.view.backgroundColor = .white
        incidentsNavigationController.extendedLayoutIncludesOpaqueBars = true
        
        let myInsurancesVC = factory?.myInsurancesModule.assembleViewController() ?? UIViewController()
        
        myInsurancesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-insurance"), selectedImage: UIImage(named: "tab-insurance-selected"))
        let myInsuranceNavigationController = UINavigationController(rootViewController: myInsurancesVC)
        myInsuranceNavigationController.view.backgroundColor = .white
        let mainProfileVC = factory?.mainProfileModule.assembleViewController() ?? UIViewController()
        mainProfileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab-settings"), selectedImage: UIImage(named: "tab-settings-settings"))
        self.tabBar.tintColor = Colors.primaryGreen
        let mainProfileNavigationController = UINavigationController(rootViewController: mainProfileVC)
        mainProfileNavigationController.view.backgroundColor = .white
        self.viewControllers = [dashboardNavigatonController, incidentsNavigationController, myInsuranceNavigationController, mainProfileNavigationController]
//        self.tabBarController?.hidesBottomBarWhenPushed = true
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
