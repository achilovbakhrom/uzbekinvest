//
//  CheckOrder.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct CheckOrder: Codable {
    
    var id: Int?
    var product: Product?
    var policyId: String?
    var startDate: String?
    var endDate: String?
    var isActive: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case product
        case policyId = "policy_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
    
}
