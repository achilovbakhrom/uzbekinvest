//
//  Registration1Interactor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol Registration1InteractorProtocol: BaseInteractor {
    var networkManager: NetworkManager { get set }
    func setData(name: String, dob: String)
}

class Registration1Interactor: Registration1InteractorProtocol {
    
    var networkManager: NetworkManager
    var presenter: BasePresenter?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func setData(name: String, dob: String) {
        
    }
    
}
