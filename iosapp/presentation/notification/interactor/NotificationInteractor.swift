//
//  NotificationInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol NotificationInteractor: BaseInteractor {
    func fetchNotifications()
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
}

class NotificationInteractorImpl: NotificationInteractor {
    
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var notificationPresenter = self.presenter as? NotificationPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func fetchNotifications() {
        self.notificationPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchNotification) { [unowned self] result in
                switch result {
                case .success(let response):
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.notificationPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(ArrayResponse<NotificationModel>.self, from: response.data)
                            self.notificationPresenter?.setNotifications(notifications: r.data ?? [])
                            self.fetchNews()
                        } catch (let error) {
                            self.notificationPresenter?.showError(msg: error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.notificationPresenter?.setLoading(isLoading: false)
                    self.notificationPresenter?.showError(msg: error.localizedDescription)
                    break
                }
        }
    }
    
    private func fetchNews() {
        
        var lang = ""
        switch translatePosition {
        case 0:
            lang = "ru"
            break
        case 1:
            lang = "uz"
            break
        case 2:
            lang = "oz"
            break
        default:
            break
        }
        
        self
            .serviceFactory
            .networkManager
            .user
            .request(.news(lang: lang)) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.notificationPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<News>.self, from: response.data)
                        self.notificationPresenter?.setNews(news: r.data ?? [])
                    } catch (let error) {
                        self.notificationPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.notificationPresenter?.setLoading(isLoading: false)
                    self.notificationPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
}
