//
//  ConfirmRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol ConfirmRouter: BaseRouter {
    func openMainPage()
}

class ConfirmRouterImpl: ConfirmRouter {
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    func openMainPage() {
        let vc = factory?.offerModule.assembleViewController() ?? UIViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
