//
//  RegistrationInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/15/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationInteractor: BaseInteractor {
    var regions: [Region] { get set }
    var serviceFactory: ServiceFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol)
    func fetchRegions()
    func sendCode(phone: String)
    func checkConfirmCode(code: String) -> Bool
    func getInitPhoneNumber() -> String?
    func register(user: User)
}


class RegistrationInteractorImpl: RegistrationInteractor {
    var presenter: BasePresenter?
    var regions: [Region] = []
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var registrationPresenter: RegistrationPresenter = self.presenter as! RegistrationPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }
    
    func fetchRegions() {
        self.registrationPresenter.setLoading2(enabled: true)
        self
            .serviceFactory
            .networkManager.regions.request(.getAllRegions) { result in
                switch result {
                case .success(let res):
                    self.registrationPresenter.setLoading2(enabled: false)
                    let decoder = JSONDecoder()
                    do {
                        let array = try decoder.decode(ArrayResponse<Region>.self, from: res.data)
                        self.registrationPresenter.setRegions(regions: array.data ?? [])
                    } catch let error {
                        print(error.localizedDescription)
                        print("error")
                    }
                    break
                case .failure(let error):
                    self.registrationPresenter.setLoading2(enabled: false)
                    debugPrint(error.localizedDescription)
                    break
                }
                
        }
    }
    
    func sendCode(phone: String) {
        self.registrationPresenter.setLoading2(enabled: true)
        self
            .serviceFactory
            .networkManager
            .auth
            .request(.sendCodeToPhone(phone: phone)) { result in
                switch result {
                case .success:
                    self.registrationPresenter.setLoading2(enabled: false)
                    self.registrationPresenter.openRegistration3VC()
                    break
                case .failure(let error):
                    self.registrationPresenter.setLoading2(enabled: false)
                    debugPrint(error.localizedDescription)
                    break
                }
                
        }
        
    }
    
    func checkConfirmCode(code: String) -> Bool {
        return (Int(code) ?? 0) != 0
    }
    
    func getInitPhoneNumber() -> String? {
        return serviceFactory.storage.fetch(key: "phone", type: String.self)
    }
    
    func register(user: User) {
        self.registrationPresenter.setLoading3(enabled: true)
        self
            .serviceFactory
            .networkManager.auth.request(.registerUser(user: user)) { result in
                switch result {
                case .success(let response):
                    self.registrationPresenter.setLoading3(enabled: false)
                    let decoder = JSONDecoder()
                    do {
                        let json = try decoder.decode(RegisterResponse.self, from: response.data)
                        self.serviceFactory.tokenFactory.saveToken(token: json.token)
                        self.registrationPresenter.openDashboard()
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.registrationPresenter.setLoading3(enabled: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
}
