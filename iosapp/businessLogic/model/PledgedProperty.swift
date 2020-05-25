//
//  PledgedProperty.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct PledgedProperty: Codable {
    
    var insuranceAmount: Int
    var years: Int
    
    init() {
        self.insuranceAmount = 0
        self.years = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
        case years
    }
    
}
