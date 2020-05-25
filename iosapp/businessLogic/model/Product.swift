//
//  Product.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

public struct Product: Codable {
    
    var id: Int
    var name: String?
    var icon: String?
    var image: String?
    var discount: Float?
    var sort: Int?
    var isFeatured: Int?
    var isActive: Int?
    var category: Category?
    var translates: Array<Translate?>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case image
        case discount
        case sort
        case isFeatured = "is_featured"
        case isActive = "is_active"
        case category
        case translates
    }
}
