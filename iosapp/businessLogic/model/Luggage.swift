//
//  Luuggage.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Luggage: Codable {
    
    var days: Int
    var insuranceAmount: Int
    
    init() {
        days = 0
        insuranceAmount = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case days
        case insuranceAmount = "insurance_amount"
    }
}
