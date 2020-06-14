//
//  RootInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol RootInteractorProtocol: BaseInteractor {
    func hasToken() -> Bool
    func hasLanguageSelected() -> Bool
    func languageSelectedFromWelcome() -> Bool
}

class RootInteractor: RootInteractorProtocol {
    
    var presenter: BasePresenter? = nil
    var tokenFactory: TokenFactory! = nil
    var storage: StorageService? = nil
    
    init(tokenFactory: TokenFactory, storage: StorageService) {
        self.tokenFactory = tokenFactory
        self.storage = storage
    }
    
    func hasLanguageSelected() -> Bool {
        if let lng = self.storage?.fetch(key: "language", type: String.self), lng != "" {
            return true
        }
        return false
    }
    
    func hasToken() -> Bool {
        return tokenFactory.getToken() != nil
    }
    
    func languageSelectedFromWelcome() -> Bool {
        if let _ = self.storage?.fetch(key: "welcome", type: Bool.self) {
            self.storage?.removeKey(key: "welcome")
            return true
        }
        return false
    }
    
}
