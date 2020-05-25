//
//  StorageSeervice.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

class StorageService {
    
    var memory: Memory! = nil
    
    init(memory: Memory) {
        self.memory = memory;
    }
    
    func save<T>(key: String, value: T) {
        self.memory.write(key: key, value: value)
    }
    
    func fetch<T>(key: String, type: T.Type) -> T? {
        return self.memory.read(key: key, type: type)
    }
    
    func saveObject<T: Codable>(key: String, value: T) {
        self.memory.writeObject(key: key, value: value)
    }
    
    func fetchObject<T: Codable>(key: String, type: T.Type) -> T? {
        return try? self.memory.readObject(key: key, type: type)
    }
    
    func removeKey(key: String) {
        self.memory.remove(key: key)
    }
    
    func removeAll() {
        self.memory.removeAll()
    }
    
}
