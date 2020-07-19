//
//  WelcomeInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol WelcomeInteractorProtocol: BaseInteractor {
    func setLanguage(lang: String)
}

class WelcomeInteractor: WelcomeInteractorProtocol {
    
    var presenter: BasePresenter?
    
    lazy var welcomePresenter: WelcomePresenterProtocol? = {
        return self.presenter as? WelcomePresenterProtocol
    }()
    
    var storage: StorageService!
    
    init(storage: StorageService) {
        self.storage = storage
    }
    
    func setLanguage(lang: String) {
//        self.storage.save(key: "welcome", value: true)        
        self.storage.save(key: "language", value: lang)
    }
    
}
