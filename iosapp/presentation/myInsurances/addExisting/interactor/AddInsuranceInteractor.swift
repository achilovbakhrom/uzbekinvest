//
//  AddInsuranceInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol AddInsuranceInteractor: BaseInteractor {
    
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func getShowAgainFlag() -> Bool?
    func setShowAgainFlag(isShowAgain: Bool)
    func addPinfl(pinfl: Pinfl)
    
}

class AddingInsuranceInteractorImpl: AddInsuranceInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol?
    private lazy var addInsurancePresenter = self.presenter as? AddingInsurancePresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func getShowAgainFlag() -> Bool? {
        return self.serviceFactory?.storage.fetch(key: "showAgain", type: Bool.self)
    }
    
    func setShowAgainFlag(isShowAgain: Bool) {
        self.serviceFactory?.storage.save(key: "showAgain", value: isShowAgain)
    }
    
    func addPinfl(pinfl: Pinfl) {
        self
            .serviceFactory?
            .networkManager
            .user
            .request(.addPinfl(pinfl: pinfl), completion: { result in
                switch result {
                case .success(let response):
                    if response.statusCode < 300 {
                        NotificationCenter.default.post(Notification(name: Notification.Name("updatePinfl")))
                        self.addInsurancePresenter?.goToMainPage()
                    } else {
                        self.addInsurancePresenter?.showError(msg: "Что то пошло не так!")
                    }
                    break
                case .failure(let error):
                    self.addInsurancePresenter?.showError(msg: error.localizedDescription)
                    break
                }
            })
    }
    
}
