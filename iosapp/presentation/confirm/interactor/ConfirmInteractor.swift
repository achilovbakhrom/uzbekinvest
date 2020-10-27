//
//  ConfirmInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol ConfirmInteractor: BaseInteractor {
    var serviceFactory: ServiceFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol)
    func checkConfirmCode(code: String) -> Bool
    func sendConfirmCode(phone: String, code: Int)
    func resendCode(phone: String)
}


class ConfirmInteractorImpl: ConfirmInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var confirmPresenter = self.presenter as? ConfirmPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }
    
    func sendConfirmCode(phone: String, code: Int) {
        let auth = Auth(phone: phone, code: code)
        self.confirmPresenter?.setLoading(isLoading: true)
        self.serviceFactory.networkManager.auth.request(.login(auth: auth)) { [unowned self] result in
            switch result {
            case .success(let response):
                self.confirmPresenter?.setLoading(isLoading: false)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response<AuthResult>.self, from: response.data)
                    self.serviceFactory.tokenFactory.saveToken(token: result.data?.token ?? "")
                    self.serviceFactory.storage.saveObject(key: "profile", value: result.data)
                    self.confirmPresenter?.openMainPage()
                } catch (let error) {
                    self.confirmPresenter?.showError(msg: "incorrect_confirm_code".localized())
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.confirmPresenter?.setLoading(isLoading: false)
                self.confirmPresenter?.showError(msg: "incorrect_confirm_code".localized())
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func checkConfirmCode(code: String) -> Bool {
        return Int(code) ?? 0 != 0
    }
    
    func resendCode(phone: String) {
        self.serviceFactory.networkManager.auth.request(.checkPhoneNumber(phone: phone)) { _ in }
    }
    
}
