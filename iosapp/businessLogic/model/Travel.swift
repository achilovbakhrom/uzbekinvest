//
//  Travel.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Travel: Codable {
    
    var countries: [Int]?
    var members: [Member]?
    var startDate: String?
    var endDate: String?
    var clazz: String?
    var program: Int
    var type: Int
    var plan: Int
    var insuranceAmount: Int
    var purpose: Int
    
    init() {
        countries = []
        members = []
        program = 0
        type = 0
        plan = 0
        insuranceAmount = 0
        purpose = 0
        members = []
    }
    
    enum CodingKeys: String, CodingKey {
        case countries
        case members
        case startDate = "start_date"
        case endDate = "end_date"
        case clazz = "class"
        case program
        case type
        case plan
        case insuranceAmount = "insurance_amount"
        case purpose
    }
    
}

struct Member: Codable {
    var dob: String
}
