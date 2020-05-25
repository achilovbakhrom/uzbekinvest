//
//  Memory.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol Memory {
    func write<T>(key: String, value: T)
    func writeObject<T: Codable>(key: String, value: T)
    func read<T: Any>(key: String, type: T.Type) -> T?
    func readObject<T: Codable>(key: String, type: T.Type) throws -> T?
    func remove(key: String)
    func removeAll()
}

enum MemoryErrors: Error {
    case unsupportedType
}

class MemoryImpl: Memory {
    
    let defaults: UserDefaults
    
    init() {
        defaults = UserDefaults.standard;
    }
    
    func writeObject<T: Codable>(key: String, value: T) {
        defaults.set(value.toJSONData()!, forKey: key);
        defaults.synchronize()
    }
    
    func write<T>(key: String, value: T) {
        defaults.set(value, forKey: key);
        defaults.synchronize()
    }
    
    func read<T: Any>(key: String, type objectType: T.Type) -> T? {
        return defaults.value(forKey: key) as? T
    }
    
    func readObject<T>(key: String, type objectType: T.Type) throws -> T? where T : Decodable, T : Encodable {
        guard let data = defaults.value(forKey: key) as? Data else {
            return nil
        }
        return try JSONDecoder().decode(objectType, from: data) as T
    }
    
    func remove(key: String) {
        defaults.set(nil, forKey: key)
        defaults.synchronize()
    }
    
    func removeAll() {
        Array(UserDefaults.standard.dictionaryRepresentation().keys).forEach { (key) in
            remove(key: key)
        }
    }
    
}
