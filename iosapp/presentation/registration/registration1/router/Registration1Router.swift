//
//  Registration1Router.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol Registration1RouterProtocol: BaseRouter {
    init(factory: AssemblyFactoryProtocol, vc: UIViewController)
}

class Registration1Router: Registration1RouterProtocol {
    
    var factory: AssemblyFactoryProtocol?
    var viewController: UIViewController?
    
    required init(factory: AssemblyFactoryProtocol, vc: UIViewController) {
        self.factory = factory
        self.viewController = vc
    }
    
    
    
}
