//
//  IncidentMetadata.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/6/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct IncidentMetaItem: Codable {
    
    var types: Array<IncidentTypeItem>
    var instructions: Array<Instruction>
    var contacts: Array<ContactsMeta>?
    
    init() {
        types = []
        instructions = []
        contacts = []
    }
}

struct IncidentTypeItem: Codable {
    var name: String
    var translates: Array<Translate>
    
    init() {
        name = ""
        translates = []
    }
}

struct Instruction: Codable {
    var instructions: String?
    var lang: String = ""
    init() {
        instructions = nil
        lang = ""
    }
}

struct ContactsMeta: Codable {
    var contacts: String?
    var lang: String
    init() {
        contacts = nil
        lang = ""
    }
}

