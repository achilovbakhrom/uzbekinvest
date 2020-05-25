//
//  MobilePhone.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct MobilePhone: Codable {
    var phonePrice: Int
    
    init() {
        phonePrice = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case phonePrice = "phone_price"
    }
}
