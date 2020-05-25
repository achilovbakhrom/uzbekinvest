//
//  ServiceFactory.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

class ServiceFactory: ServiceFactoryProtocol {
    
    lazy var networkManager: NetworkManager = {
        let manager = NetworkManager(tokenFactory: self.tokenFactory)
        return manager
    }()
    
    var tokenFactory: TokenFactory = {
        let memory = MemoryImpl()
        let tokenFactory = TokenFactoryImpl(memory: memory)
        return tokenFactory;
    }()
    
    var storage: StorageService = {
        let memory = MemoryImpl()
        let storage = StorageService(memory: memory)
        return storage
    }()
    
    var validator: ValidatorProtocol = {
        let validator = Validator()
        return validator;
    }()
    
    var formatter: Formatter = {
        let formatter = Formatter()
        return formatter
    }()
}
