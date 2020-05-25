//
//  Work.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

struct Work: Codable {
    var id: Int
    var name: String?
    var group: String?
    var translates: Array<Translate?>?
}
