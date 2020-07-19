//
//  Metadata.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 7/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Metadata: Codable {
    var types: [MetadataType?]?
    var instructions: [MetadataInstruction?]?
    var contacts: [MetadataContact?]?
}

struct MetadataType: Codable {
    var name: String?
    var translates: [Translate?]?
}

struct MetadataInstruction: Codable {
    var lang: String?
    var instruction: String?
}

struct MetadataContact: Codable {
    var lang: String?
    var contacts: String?
}
