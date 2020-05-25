//
//  OfficesInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//
import Foundation

protocol OfficesInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchOffices()
}

class OfficesInteractorImpl: OfficesInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var officePresenter: OfficesPresenter? = self.presenter as? OfficesPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func fetchOffices() {
        self.officePresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchOffices) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.officePresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let r = try decoder.decode(ArrayResponse<Office>.self, from: response.data)
                        self.officePresenter?.setOfficesList(list: r.data ?? [])                        
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.officePresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
}
