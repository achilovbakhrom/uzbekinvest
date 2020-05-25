//
//  ExportOperation.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct ExportOperation: Codable {
    var id: Int64
    var region: Region
    var type: String
    var form: String
    var name: String
    var contactName: String
    var contactPhones: [String]
    var dealDescription: String
    var dealSum: Int
    var borrower: String
    var loanTerm: String
    var payTerm: String
    var customer: String
    var contract: String
}
