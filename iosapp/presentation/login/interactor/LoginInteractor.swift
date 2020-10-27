//
//  RegistrationInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

protocol LoginInteractorProtocol: BaseInteractor {
    func validatePhone(phone: String) -> Bool
    func checkPhoneNumberForExistance(phone: String)
}

class LoginInteractor: LoginInteractorProtocol {
    
    var presenter: BasePresenter?
    
    private var validatorSerivce: ValidatorProtocol
    private var networkManager: NetworkManager
    private var storageService: StorageService
    lazy var loginPresenter: LoginPresenterProtocol? = {
        return self.presenter as? LoginPresenterProtocol
    }()
    
    init(validator: ValidatorProtocol, networkManager: NetworkManager, storage: StorageService) {
        self.validatorSerivce = validator
        self.networkManager = networkManager
        self.storageService = storage
    }
    
    func validatePhone(phone: String) -> Bool {
        return self.validatorSerivce.validatePhone(phoneNumber: phone.digits)
    }
    
    func checkPhoneNumberForExistance(phone: String) {
        self.loginPresenter?.setLoading(loading: true)
        self.networkManager.auth.request(.checkPhoneNumber(phone: phone)) { [unowned self] result in
            self.loginPresenter?.setLoading(loading: false)
            switch result {
            case .success:
                self.storageService.save(key: "phone", value: phone)
                self.loginPresenter?.goToConfirm(phone: phone)
                break
            case .failure(let error):
                if let response = error.response, response.statusCode == 401 {
                    self.loginPresenter?.goToRegistration(phone: phone)
                }
                break
            }
        }
    }
    
}
