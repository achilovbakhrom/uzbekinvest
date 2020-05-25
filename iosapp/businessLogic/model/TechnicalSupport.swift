//
//  TechnicalSupport.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct TechnicalSupport: Codable {
    var insuranceAmount: Int
    
    init() {
        insuranceAmount = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
    }
}
