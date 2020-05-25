//
//  Sport.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Sport: Codable {
    var insuranceAmount: Int
    var sportId: Int
    var isCompetition: Bool
    var competitionPeriod: Int
    var quantityLt15: Int
    var quantityLt18: Int
    var quantityLt30: Int
    var quantityMte30: Int
    
    init() {
        insuranceAmount = 0
        sportId = -1
        isCompetition = true
        competitionPeriod = -1
        quantityLt15 = 0
        quantityLt18 = 0
        quantityLt30 = 0
        quantityMte30 = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case insuranceAmount = "insurance_amount"
        case sportId = "sport_id"
        case isCompetition = "is_competition"
        case competitionPeriod = "competition_period"
        case quantityLt15 = "quantity_lt_15"
        case quantityLt18 = "quantity_lt_18"
        case quantityLt30 = "quantity_lt_30"
        case quantityMte30 = "quantity_mte_30"
    }
}

struct SportModel: Codable {
    var id: Int
    var name: String?
    var coef: Int?
    var group: String?
    var isFeatured: Int = 0
    var translates: Array<Translate?>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coef
        case group
        case isFeatured = "is_featured"
        case translates
    }
}
