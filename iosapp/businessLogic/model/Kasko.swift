//
//  Kasko.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Kasko: Codable {
    var type: Int
    var carPrice: Int
    var period: Float
    
    init() {
        type = 0
        carPrice = 0
        period = 0.0
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case carPrice = "car_price"
        case period
    }
}
