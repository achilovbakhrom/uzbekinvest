//
//  RegisterResponse.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/22/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct RegisterResponse: Codable {
    var id: Int
    var name: String?
    var phone: String?
    var address: String?
    var dob: String?
    var isActive: Int?
    var region: Region?
    var createdAt: String?
    var token: String
    var expires: Int
    
    init() {
        id = -1
        name = nil
        phone = nil
        address = nil
        dob = nil
        isActive = 1
        region = nil
        createdAt = nil
        token = ""
        expires = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case dob
        case isActive = "is_active"
        case region
        case createdAt = "created_at"
        case token
        case expires
    }
    
}
