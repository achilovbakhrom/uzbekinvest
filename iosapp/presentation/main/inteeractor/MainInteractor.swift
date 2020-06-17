//
//  MainInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MainInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func getProductById(id: String)
    func getOrderById(id: String)
    func getIncidentbyId(id: String)
}

class MainInteractorImpl: MainInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var mainPresenter = self.presenter as? MainPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func getProductById(id: String) {
        self
            .serviceFactory
            .networkManager
            .product
            .request(.fetchAllProduct) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<Product>.self, from: response.data)
                        let f = (r.data ?? []).filter { String($0.id) == id }
                        if !f.isEmpty {
                            self.mainPresenter?.setProduct(product: f[0])
                        }
                    } catch (let error) {
                        self.mainPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error)
                    }
                    break
                case .failure(let error):
                    self.mainPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error)
                    break
                }
        }
    }
    
    func getOrderById(id: String) {
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchOrderById(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<MyInsurance>.self, from: response.data)
                        self.mainPresenter?.setMyInsurance(myInsurance: r.data!)
                    } catch (let error) {
                        self.mainPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error)
                    }
                    break
                case .failure(let error):
                    self.mainPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error)
                    break
                }
        }
    }
    
    func getIncidentbyId(id: String) {
        self
            .serviceFactory
            .networkManager
            .incident
            .request(.fetchIncidentById(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<Incident>.self, from: response.data)
                        self.mainPresenter?.setIncident(incident: r.data!)
                    } catch (let error) {
                        self.mainPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error)
                    }
                    break
                case .failure(let error):
                    self.mainPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error)
                    break
                }
        }
    }
    
}

