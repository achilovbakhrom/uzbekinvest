//
//  Country.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Country: Codable {
    var id: Int?
    var name: String?
    var code: String?
    var zone: Int?
    var isShengen: Int?
    var isFeatured: Int?
    var translates: [Translate?]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case zone
        case isShengen = "is_shengen"
        case isFeatured = "is_featured"
        case translates
    }
}
