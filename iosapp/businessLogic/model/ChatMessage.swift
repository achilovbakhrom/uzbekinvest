//
//  ChatMessage.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct ChatMessage: Codable {
    
    var admin: String?
    var createdAt: String?
    var id: Int?
    var message: String?
    
    init() {
        admin = nil
        createdAt = nil
        id = nil
        message  = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case admin
        case createdAt = "created_at"
        case message
    }
    
}
