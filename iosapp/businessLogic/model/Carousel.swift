//
//  Carousel.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/22/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Carousel: Codable {
    var id: Int
    var image: String?
    var isActive: Int?
    var sort: Int?
    var translates: [CarouselTranslate?]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case isActive = "is_active"
        case translates
    }
}

struct CarouselTranslate: Codable {
    var title: String?
    var description: String?
    var url: String?
    var lang: String?
}
