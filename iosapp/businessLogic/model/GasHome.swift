//
//  GasHome.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct GasHome: Codable {
    var insuranceAmount: Int
    var type: Int
    var franchise: Int
    
    init() {
        insuranceAmount = 0
        type = 0
        franchise = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
        case type
        case franchise
    }
}
