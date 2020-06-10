//
//  IncidentsDetailInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsDetailInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchIncidents()
    func fetchPinflOrders()
}

class IncidentsDetailInteractorImpl: IncidentsDetailInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var incidentsPresenter = self.presenter as? IncidentsDetailPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func fetchIncidents() {
        self.incidentsPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchUserInsurances) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.incidentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(ArrayResponse<MyInsurance>.self, from: response.data)
                            self.incidentsPresenter?.setInsurances(insurances: r.data ?? [])
                        } catch (let error) {
                            debugPrint(error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func fetchPinflOrders() {
        self.incidentsPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchOrders) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.incidentsPresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.incidentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(ArrayResponse<MyInsurance>.self, from: response.data)
                            self.incidentsPresenter?.setInsurances(insurances: r.data ?? [])
                        } catch (let error) {
                            debugPrint(error.localizedDescription)
                        }
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
