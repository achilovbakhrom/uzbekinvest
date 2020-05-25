//
//  MyInsurance.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import ObjectMapper

struct MyInsurance: Codable {
    
    var id: Int
    var product: Product?
    var region: Region?
    var user: User?
    var supervisor: String?
    var status: String?
    var paymentMethod: String?
    var startDate: String?
    var endDate: String?
    var premiumAmount: Int
    var totalAmount: Int
    var insuranceAmount: Int?
    var membersCount: Int
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case product
        case region
        case user
        case supervisor
        case status
        case paymentMethod = "payment_method"
        case startDate = "start_date"
        case endDate = "end_date"
        case premiumAmount = "premium_amount"
        case totalAmount = "total_amount"
        case insuranceAmount = "insurance_amount"
        case membersCount = "members_count"
        case createdAt = "created_at"
    }
    
}

class PropertyArrayResposne: Mappable {
    var data: Array<MyInsuranceProperties>?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class MyInsuranceProperties: NSObject, Mappable {
    dynamic var properties = [String:Any]()
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        properties <- map["properties"]
    }
}
