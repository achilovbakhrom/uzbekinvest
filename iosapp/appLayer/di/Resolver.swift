//
//  Resolver.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol Resolver {
    func resolve(_ type: Service.Type) -> Service
}
