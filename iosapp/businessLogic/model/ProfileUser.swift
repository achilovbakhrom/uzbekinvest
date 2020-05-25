//
//  ProfileUser.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct ProfileUser: Codable {
    
    var id: Int
    var name: String
    var phone: Int?
    var address: String?
    var dob: String?
    var isActive: Int?
    var region: Region?
    var completedOrders: Int?
    var daysActive: Int?
    var incidents: Int?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case address
        case dob
        case isActive = "is_active"
        case region
        case completedOrders = "completed_orders"
        case daysActive = "days_active"
        case incidents
        case createdAt = "created_at"
    }
    
}
