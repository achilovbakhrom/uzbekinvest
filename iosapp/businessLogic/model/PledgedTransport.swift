//
//  PledgedTransport.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct PledgedTransport: Codable {
    
    var insuranceAmount: Int?
    var age: Int?
    var experience: Int?
    
    init() {
        insuranceAmount = 0
        age = 0
        experience = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
        case age = "age"
        case experience = "experience"
    }
    
}
