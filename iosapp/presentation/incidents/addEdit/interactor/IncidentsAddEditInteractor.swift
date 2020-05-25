//
//  IncidentsAddEditInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol IncidentsAddEditInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func createIncident(incident: Incident, files: [Int: [String: Data]])
}


class IncidentsAddEditInteractorImpl: IncidentsAddEditInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var incidentsPresenter = self.presenter as? IncidentsAddEditPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func createIncident(incident: Incident, files: [Int : [String : Data]]) {
        var index = 0
        var r: [String: Data] = [:]
        for key in files.keys {
            let k = "images[\(index)]"
            let val = files[key]
            if let v = val {
                for k1 in v.keys {
                    r[k] = v[k1]
                }
            }
            
            index += 1
        }
        self
            .serviceFactory
            .networkManager
            .incident
            .request(.createIncident(incident: incident, files: r)) { result in
                self.incidentsPresenter?.setLoading(isLoading: true)
                switch result {
                case .success(let response):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.incidentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        self.incidentsPresenter?.openAndUpdateIncidents()
                    }
                    break
                case .failure(let error):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    
    
    
}
