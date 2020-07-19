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
    func createIncident(incident: Incident, type: String, files: [Int: [String: Data]])
    func fetchIncidentMetadata(productCode: String)
    func fetchIncidentMetadataInfo(productCode: String)
}


class IncidentsAddEditInteractorImpl: IncidentsAddEditInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var incidentsPresenter = self.presenter as? IncidentsAddEditPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func createIncident(incident: Incident, type: String, files: [Int : [String : Data]]) {
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
            .request(.createIncident(incident: incident, type: type, files: r)) { result in
                self.incidentsPresenter?.setLoading(isLoading: true)
                switch result {
                case .success(let response):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.incidentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else if response.statusCode < 300 {                        
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
    
    func fetchIncidentMetadata(productCode: String) {
        self
        .serviceFactory
        .networkManager
        .incident
            .request(.fetchIncidentMeta(productCode: productCode)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<IncidentMetaItem>.self, from: response.data)
                        self.incidentsPresenter?.setIncidentMetaItemList(list: r.data!)
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func fetchIncidentMetadataInfo(productCode: String) {
        self
        .serviceFactory
        .networkManager
        .incident
            .request(.fetchIncidentMeta(productCode: productCode)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<IncidentMetaItem>.self, from: response.data)
                        var instruction = ""
                        if (r.data?.instructions.count ?? 0) > translatePosition {
                            instruction = r.data?.instructions[translatePosition].instructions ?? ""
                        } else if (r.data?.instructions.count ?? 0) > 0 {
                            instruction = r.data?.instructions[0].instructions ?? ""
                        }                        
                        self.incidentsPresenter?.setInfo(text: instruction)
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    
}
