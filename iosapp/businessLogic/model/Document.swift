//
//  Document.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct Document: Codable {
    var id: Int
    var name: String?
    var translates: Array<Translate?>?
}
