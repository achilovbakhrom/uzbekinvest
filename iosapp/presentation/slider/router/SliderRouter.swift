//
//  SliderRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol SliderRouterProtocol: BaseRouter {
    func openLoginPage()
}

class SliderRouter: SliderRouterProtocol {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    func openLoginPage() {
        let vc = factory?.loginModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
}
