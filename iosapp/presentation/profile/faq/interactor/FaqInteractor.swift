//
//  FaqInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol FaqInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchFaqList()
}

class FaqInteractorImpl: FaqInteractor {
    
    var serviceFactory: ServiceFactoryProtocol
    var presenter: BasePresenter?
    
    private lazy var faqPreseenter = self.presenter as? FaqPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func fetchFaqList() {
        self.faqPreseenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.faq) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.faqPreseenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<Question>.self, from: response.data)
                        self.faqPreseenter?.setFaqList(list: r.data ?? [])
                    } catch (let error) {
                        self.faqPreseenter?.showError(msg: error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.faqPreseenter?.setLoading(isLoading: false)
                    self.faqPreseenter?.showError(msg: error.localizedDescription)
                    break
                }
        }
    }
    
}
