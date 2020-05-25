//
//  TokenProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol TokenFactory {
    func getToken() -> String?
    func saveToken(token: String)
    func removeToken()
}

class TokenFactoryImpl: TokenFactory {
    var memory: Memory
    
    init(memory: Memory) {
        self.memory = memory
    }
    func getToken() -> String? {
        return memory.read(key: "token", type: String.self)
    }
    func saveToken(token: String) {
        memory.write(key: "token", value: token)
    }
    func removeToken() {
        memory.remove(key: "token")
    }
}
