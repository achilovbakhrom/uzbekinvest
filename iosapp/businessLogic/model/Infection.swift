//
//  Infection.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Infection: Codable {
    
    var insuranceAmount: Int
    var quantityLt7: Int
    var quantityLt60: Int
    var quantityMte60: Int
    
    init() {
        insuranceAmount = 0
        quantityLt7 = 0
        quantityLt60 = 0
        quantityMte60 = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
        case quantityLt7 = "quantity_lt_7"
        case quantityLt60 = "quantity_lt_60"
        case quantityMte60 = "quantity_mte_60"
    }    
}
