//
//  WelcomeRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol WelcomeRouterProtocol: BaseRouter {
    func openSlider()
}

class WelcomeRouter: WelcomeRouterProtocol {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    func openSlider() {
        let vc = factory?.sliderModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
