//
//  Incident.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct IncidentImage: Codable {
    var id: Int?
    var image: String?
}

struct IncidentOrder: Codable {
    var id: Int?
    var product: Product?
    var region: Region?
    var user: User?
    var supervisor: String?
    var status: String?
    var paymentMethod: String?
    var startDate: String?
    var endDate: String?
    var premiumAmount: Int?
    var totalAmount: Int?
    var insuranceAmount: Int?
    var membersCount: Int?
    
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
    }
}

struct Incident: Codable {
    var id: Int?
    var user: User?
    var supervisor: String?
    var orderId: Int?
    var order: IncidentOrder?
    var lattitude: String?
    var longitude: String?
    var address: String?
    var comment: String?
    var status: String?
    var paidAmount: Int?
    var createdAt: String?
    var images: Array<IncidentImage?>?
    var startDate: String?
    var endDate: String?
    
    init() {
        id = nil
        user = nil
        supervisor = nil
        orderId = nil
        lattitude = nil
        longitude = nil
        address = nil
        comment = nil
        status = nil
        paidAmount = nil
        createdAt = nil
        images = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case supervisor
        case orderId = "order_id"
        case lattitude
        case longitude
        case address
        case comment
        case status
        case paidAmount = "paid_amount"
        case createdAt = "created_at"
        case images
        case order
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
}
