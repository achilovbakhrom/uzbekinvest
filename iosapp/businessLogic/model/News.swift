//
//  News.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

public struct News: Codable {
    
    var id: Int?
    var image: String?
    var title: String?
    var text: String?
    var lang: String?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case title
        case text
        case lang
        case createdAt = "created_at"
    }
    
}
