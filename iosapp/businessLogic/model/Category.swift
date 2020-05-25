//
//  Category.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct Category: Codable {
    var id: Int
    var name: String?
    var sort: Int?
    var translates: Array<Translate?>?
    init() {
        self.id = -1
        self.name = ""
        self.sort = 0
        self.translates = []
    }
}
