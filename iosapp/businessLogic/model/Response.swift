//
//  Response.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    var code: Int?
    var message: String?
    var data: T?
    init() {
        code = 0
        message = ""
        data = nil
    }
}

struct DocsResponse: Codable {
    var mainDocs: Array<Document>?
    var secondaryDocs: Array<Document>?
}

struct ArrayResponse<T: Codable>: Codable {
    var code: Int?
    var message: String?
    var data: Array<T>?
    init() {
        code = 0
        message = ""
        data = []
    }
}

struct InsuranceCalculatedResult: Codable {
    var totalAmount: Int
    var premiumAmount: Int
    var referer: Referer?
    enum CodingKeys: String, CodingKey {
        case totalAmount = "total_amount"
        case premiumAmount = "premium_amount"
        case referer
    }
}

struct Referer: Codable {
    var id: Int
    var code: String?
    var name: String?
}
