//
//  OfferInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol OfferInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchOffer()
}


class OfferInteractorImpl: OfferInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var offerPresenter: OfferPresenter = self.presenter as! OfferPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func fetchOffer() {
        self.offerPresenter.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.fetchOffer) { [unowned self] result in
                self.offerPresenter.setLoading(isLoading: false)
                switch result {
                case .success(let response):
                    
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(TermsOfUse.self, from: response.data)
                        self.offerPresenter.setOfferText(text: r.content ?? "")
                    } catch (let error) {
                        debugPrint(error)
                    }
                    break
                case .failure(let error):
                    debugPrint(error)
                    break
                }                
        }
    }
    
    
    
    
}

struct TermsOfUse: Codable {
    var content: String?
}
