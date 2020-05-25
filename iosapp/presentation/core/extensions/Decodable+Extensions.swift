//
//  Decodable+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    self = try decoder.decode(Self.self, from: data)
  }
}
