//
//  Order.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Order: Codable {
    var product: Product?
    var user: User?
    var startDate: String?
    var endDate: String?
    var premiumAmount: Int?
    var insuranceAmount: Int?
    
    enum CondingKeys: String, CodingKey {
        case product
        case user
        case startDate = "start_date"
        case endDate = "end_date"
        case premiumAmount = "premium_amount"
        case insuranceAmount = "insurance_amount"
    }
}
