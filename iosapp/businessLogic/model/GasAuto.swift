//
//  GasAuto.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct GasAuto: Codable {
    var firstPartyType: Int?
    var firstPartyAmount: Int?
    var thirdPartyAmount: Int?
    
    init() {
        firstPartyType = 0
        firstPartyAmount = nil
        thirdPartyAmount = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case firstPartyType = "first_party_type"
        case firstPartyAmount = "first_party_amount"
        case thirdPartyAmount = "third_party_amount"
    }
}
