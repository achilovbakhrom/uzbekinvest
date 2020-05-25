//
//  BaseAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol BaseAssemblyProtocol {
    var serviceFactory: ServiceFactoryProtocol { get set } 
    func assembleViewController() -> UIViewController?
}
