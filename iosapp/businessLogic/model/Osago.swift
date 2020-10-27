//
//  Osago.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

public struct Osago: Codable {
    
    var movementRegionId: Int
    var transportId: Int
    var period: String?
    var isForeigner: Bool
    var accident: Int?
    var isUnlim: Bool
    var isInvalid: Bool
    var isRetired: Bool
    var membersCount: Int?
    var paymentMethod: String?
    var startDate: String?
    var promocode: String?
    
    
    init() {
        movementRegionId = -1
        transportId = -1
        period = nil
        isForeigner = false
        accident = nil
        isUnlim = false
        isInvalid = false
        isRetired = false
        membersCount = nil
        promocode = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case movementRegionId = "movement_region_id"
        case transportId = "transport_id"
        case period
        case isForeigner = "is_foreigner"
        case accident
        case isUnlim = "is_unlim"
        case isInvalid = "is_invalid"
        case isRetired = "is_retired"
        case membersCount = "members_count"
        case promocode
    }
}
