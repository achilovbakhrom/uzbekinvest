//
//  MainProfileInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MainProfileInteractor: BaseInteractor {
    
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchMe()
    
}

class MainProfileInteractorImpl: MainProfileInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol?
    
    private lazy var mainProfilePresenter = self.presenter as? MainProfilePresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func fetchMe() {
        self.mainProfilePresenter?.setLoading(isLoading: true)
        self
            .serviceFactory?
            .networkManager
            .user
            .request(.fetchMe, completion: { [unowned self] result in
                switch result {
                case .success(let response):
                    self.mainProfilePresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory?.storage.removeKey(key: "profile")
                        self.serviceFactory?.tokenFactory.removeToken()
                        self.mainProfilePresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(Response<ProfileUser>.self, from: response.data)                            
                            self.mainProfilePresenter?.setUser(user: r.data)
                        } catch (let error) {
                            debugPrint(error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.mainProfilePresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    
}
