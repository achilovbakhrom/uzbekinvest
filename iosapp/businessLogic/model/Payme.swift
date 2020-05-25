//
//  Payme.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

public struct Payme: Codable {
    var amount: Int?
    var customerId: Int?
    var merchantId: String?
    var orderId: Int?
    
    enum CodingKeys: String, CodingKey {
        case amount
        case customerId = "customer_id"
        case merchantId = "merchant_id"
        case orderId = "order_id"
    }
    
}
