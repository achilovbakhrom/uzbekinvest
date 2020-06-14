//
//  IncidentsInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol IncidentsInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchIncidents()
    func callback(phone: String)
}

class IncidentsInteractorImpl: IncidentsInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var incidentsPresenter = self.presenter as? IncidentsListingPresenter
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func fetchIncidents() {
        self.incidentsPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .incident
            .request(.fetchAllIncidents) { result in
                switch result {
                case .success(let response):
                    
                    if response.statusCode == 401 {
                        self.incidentsPresenter?.setLoading(isLoading: false)
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.incidentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder()
                            let r = try decoder.decode(ArrayResponse<Incident>.self, from: response.data)
                            self.incidentsPresenter?.setIncidents(incidents: r.data ?? [])
                            self.incidentsPresenter?.setLoading(isLoading: false)
                        } catch (let error) {
                            self.incidentsPresenter?.setLoading(isLoading: false)
                            self.incidentsPresenter?.showError(msg: error.localizedDescription)
                            debugPrint(error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    self.incidentsPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func callback(phone: String) {
        self.incidentsPresenter?.setCallbackLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user.request(.call(phone: phone)) { result in
                switch result {
                case .success(let response):
                    self.incidentsPresenter?.setCallbackLoading(isLoading: false)
                    self.incidentsPresenter?.dismissCallbackAlert {
                        if response.statusCode < 300 {
                            self.incidentsPresenter?.showSuccess(msg: "Успешно!")
                        } else {
                            self.incidentsPresenter?.showError(msg: "Не удалость отправить запрос на обратный звонок!")
                        }
                    }                    
                    break
                case .failure(let error):
                    self.incidentsPresenter?.setCallbackLoading(isLoading: true)
                    self.incidentsPresenter?.dismissCallbackAlert {
                        self.incidentsPresenter?.showError(msg: error.localizedDescription)
                    }
                    break
                }
        }
    }
    
    
}
