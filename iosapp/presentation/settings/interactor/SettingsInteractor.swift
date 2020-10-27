//
//  SettingsInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation


protocol SettingsInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchMe()
    func updateUser(user: UserRequest)
    func fetchPinfl()
    func removePinfl(id: Int)
    func getShowAgainFlag() -> Bool?
    func clearProfileAndgetPhoneNumber() -> String
    func setLanguage(lang: String)
}

class SettingsInteractorImpl: SettingsInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol?
    private lazy var settingsPresenter = self.presenter as? SettingsPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func fetchMe() {
        self.settingsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .regions
            .request(.getAllRegions, completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<Region>.self, from: response.data)
                        self.settingsPresenter?.setRegions(regionList: r.data ?? [])
                        self.fetchCurrentUser()
                    } catch(let error) {
                        self.settingsPresenter?.setLoading(isLoading: false)
                        self.settingsPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.settingsPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    private func fetchCurrentUser() {
        self.serviceFactory?
            .networkManager
            .user
            .request(.fetchMe, completion: { result in
                switch result {
                case .success(let response):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<User>.self, from: response.data)
                        self.settingsPresenter?.setMe(user: r.data!)
                    } catch(let error) {
                        self.settingsPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.settingsPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    func updateUser(user: UserRequest) {
        self.settingsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .user
            .request(.updateUser(user: user), completion: { result in
                switch result {
                case .success:
                    self.settingsPresenter?.updateProfile()
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.settingsPresenter?.goBack()
                    break
                case .failure(let error):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.settingsPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    
    func fetchPinfl() {
        self.settingsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .user
            .request(.getPinflList, completion: { [unowned self] result in
                switch result {
                case .success(let response):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder.init()
                        let pinflList = try decoder.decode(ArrayResponse<Pinfl>.self, from: response.data)
                        self.settingsPresenter?.setPinflList(list: pinflList.data ?? [])
                    } catch(let error) {
                        self.settingsPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    
                    break
                case .failure(let error):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.settingsPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    func removePinfl(id: Int) {
        self.settingsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .user
            .request(.removePinfl(id: id), completion: { [unowned self] result in                
                switch result {
                case .success:
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.fetchPinfl()
                    break
                case .failure(let error):
                    self.settingsPresenter?.setLoading(isLoading: false)
                    self.settingsPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    func getShowAgainFlag() -> Bool? {
        return self.serviceFactory?.storage.fetch(key: "showAgain", type: Bool.self)
    }
    
    func setLanguage(lang: String) {
        UserDefaults.standard.set([lang], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()        
        Bundle.swizzleLocalization()
        self.serviceFactory?.storage.save(key: "language", value: lang)
    }
    
    func clearProfileAndgetPhoneNumber() -> String {
        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
        self.serviceFactory?.storage.removeKey(key: "profile")
        self.serviceFactory?.tokenFactory.removeToken()
        return "\(profile?.phone ?? 0)"
    }
}
