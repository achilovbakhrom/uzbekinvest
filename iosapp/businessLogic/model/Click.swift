//
//  Click.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

public struct Click: Codable {
    var merchantId: String?
    var merchantServiceId: String?
    var merchantTransAmount: Int?
    var merchantTransId: Int?
    var merchantTransNote: String?
    var merchantUserId: String?
    var signString: String?
    var signTime: String?
    
    enum CodingKeys: String, CodingKey {
        case merchantId = "merchant_id"
        case merchantServiceId = "merchant_service_id"
        case merchantTransAmount = "merchant_trans_amount"
        case merchantTransId = "merchant_trans_id"
        case merchantTransNote = "merchant_trans_note"
        case merchantUserId = "merchant_user_id"
        case signString = "sign_string"
        case signTime = "sign_time"
    }
}
