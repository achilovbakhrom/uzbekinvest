//
//  ServiceFactory.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol ServiceFactoryProtocol: class {
    var networkManager: NetworkManager { get }
    var tokenFactory: TokenFactory { get }
    var storage: StorageService { get }
    var validator: ValidatorProtocol { get }
    var formatter: Formatter { get }
}
