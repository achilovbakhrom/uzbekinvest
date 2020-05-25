//
//  AuthResult.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/31/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct AuthResult: Codable {
    var id: Int
    var name: String?
    var phone: Int
    var address: String?
    var dob: String?
    var isActive: Int
    var region: Region?
    var token: String
    var createdAt: String
    var expires: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case address
        case dob
        case isActive = "is_active"
        case region
        case token
        case createdAt = "created_at"
        case expires
    }
}
