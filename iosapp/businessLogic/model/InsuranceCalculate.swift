//
//  InsuranceCalculate.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

public struct InsuranceCalculate: Codable {
    var calcType: String
    var location: String
    var transportType: String
    var period: String
    var unlim: Bool
    var accident: Int?
    var foreigner: Bool
    var staj: Int
    var year: Int
    var insuranceAmount: Double
    var type: String
    var age: Int
    var countryId: Int64
    var startPeriod: String
    var endPeriod: String
    var purpose: String
    var klass: String
    var limit: Int
    var isStudent: Bool
}

