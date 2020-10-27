//
//  User.swift
//  e-insurance app
//
//  Created by Bakhrom Achilov on 12/24/19.
//  Copyright © 2019 Bakhrom Achilov. All rights reserved.
//
import Foundation

public struct User: Codable {
    
    var id: Int?
    var region: Region?    
    var name: String = ""
    var dob: String?
    var phone: Int?
    var code: Int?
    var passportSerial: String?
    var passportNumber: String?
    var address: String?
    var isActive: Int?
    var pinfl: Int?
    
    init() {
        id = nil
        region = nil
        name = ""
        dob = ""
        phone = 0
        code = -1
        passportSerial = nil
        passportNumber = nil
        address = ""
        isActive = 0
        pinfl = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case region
        case id
        case name
        case dob
        case phone
        case code
        case passportSerial
        case passportNumber
        case address
        case isActive = "is_active"
        case pinfl
    }
}

public struct UserRequest: Codable {
    var id: Int?
    var phone: Int?
    var name: String?
    var address: String?
    var dob: String?
    var region_id: Int?
    var code: Int?
    
    init() {
        id = nil
        phone = nil
        name = nil
        address = nil
        dob = nil
        region_id = nil
        code = nil
    }
}
