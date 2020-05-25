//
//  OrderCheckInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol OrderCheckInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)    
    func checkOrder(serial: String, polisNumber: Int)
}

class OrderCheckInteractorImpl: OrderCheckInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol?
    private lazy var orderCheckPresenter = self.presenter as? OrderCheckPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func checkOrder(serial: String, polisNumber: Int) {
        self.orderCheckPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory?
            .networkManager
            .orders
            .request(.checkOrder(seria: serial, number: polisNumber), completion: { [unowned self] result in
                switch result {
                case .success(let response):
                    self.orderCheckPresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory?.storage.removeKey(key: "profile")
                        self.serviceFactory?.tokenFactory.removeToken()
                        self.orderCheckPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else if response.statusCode == 400 {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(ErrorEntity.self, from: response.data)
                            self.orderCheckPresenter?.showError(msg: r.message ?? "")
                        } catch (let error) {
                            self.orderCheckPresenter?.showError(msg: error.localizedDescription)
                            debugPrint(error.localizedDescription)
                        }
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(Response<CheckOrder>.self, from: response.data)
                            self.orderCheckPresenter?.setData(data: r.data!)
                            self.orderCheckPresenter?.openOrderCheck2VC()
                        } catch (let error) {
                            self.orderCheckPresenter?.showError(msg: error.localizedDescription)
                            debugPrint(error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.orderCheckPresenter?.setLoading(isLoading: false)
                    self.orderCheckPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    
    
    
}
