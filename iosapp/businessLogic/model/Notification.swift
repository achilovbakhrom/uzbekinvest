//
//  Notification.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct NotificationModel: Codable {
    var id: Int?
    var image: String?
    var type: String
    var createdAt: String
    var translates: Array<NotificationTranslate?>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case type
        case createdAt = "created_at"
        case translates
    }
    
}

struct NotificationTranslate: Codable {
    var title: String
    var description: String
    var lang: String
}
