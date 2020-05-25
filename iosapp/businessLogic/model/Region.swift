//
//  Region.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

public struct Region: Codable {
    
    var id: Int
    var name: String
    var isRegion: Int?
    var translates: Array<Translate?>?
    var children: Array<Region?>?
    
    init() {
        id = 0
        isRegion = 1
        name = ""
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isRegion = "is_region"
        case translates
        case children
    }
    
}
