//
//  UserFile.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct UserFile: Codable {
    var id: Int
    var name: String
    var mimeType: String?
    var document: Document?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mimeType = "mime_type"
        case document
    }
    
}
