//
//  IncidentInfoInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 7/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol IncidentInfoInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchMetadata(code: String)
    
    
}

class IncidentInfoInteractorImpl: IncidentInfoInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var incidentsPresenter = self.presenter as? IncidentInfoPresenter
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func fetchMetadata(code: String) {
        self
            .serviceFactory
            .networkManager
            .others
            .request(.fetchMetadata(productCode: code)) { [unowned self] result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<Metadata>.self, from: response.data)
                        if (r.data?.contacts?.count ?? 0) > 0 {
                            r.data?.contacts?.forEach({ t in
                                if t?.lang == translateCode {
                                    self.incidentsPresenter?.setDescription(desc: t?.contacts ?? "")
                                }
                            })
                            
                        }
                    } catch(let error) {
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
