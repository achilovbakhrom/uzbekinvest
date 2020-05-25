//
//  Transport.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation


struct Transport: Codable {
    var id: Int
    var name: String
    var sort: Int
    var translates: [Translate]
}
