//
//  MedicalInsurance.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct MedicalInsurance: Codable {
    var insuranceAmount: Int?
    var type: Int?
    var age: Int?
    init() {
        self.insuranceAmount = 0
        self.type = 0
        self.age = -1
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
        case type
        case age
    }
    
}
