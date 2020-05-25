//
//  Office.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct Office: Codable {
    var id: Int
    var email: String?
    var phone: Int?
    var longitude: String?
    var latitude: String?
    var region: Region?
    var translates: Array<OfficeTranslate?>?
}

struct OfficeTranslate: Codable {
    var address: String?
    var workTime: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case workTime = "work_time"
    }
}
