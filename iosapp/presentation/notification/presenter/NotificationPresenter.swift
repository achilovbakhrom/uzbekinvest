//
//  NotificationPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationPresenter: BasePresenter {
    func fetchNotifications()
    func setNotifications(notifications: [NotificationModel])
    func goBack()
    func setLoading(isLoading: Bool)
    func showError(msg: String)
    func openLoginVC(phone: String)
    func setNews(news: [News])
}

class NotificationPresenterImpl: NotificationPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var notificationVC = self.view as? NotificationVC
    private lazy var notificationInteractor = self.interactor as? NotificationInteractor
    private lazy var notificationRouter = self.router as? NotificationRouter
    
    func fetchNotifications() {
        self.notificationInteractor?.fetchNotifications()
    }
    
    func setLoading(isLoading: Bool) {
        self.notificationVC?.setLoading(isLoading: isLoading)
    }
    
    func setNotifications(notifications: [NotificationModel]) {
        self.notificationVC?.setNotifications(notifications: notifications)
    }
    
    func goBack() {
        self.notificationRouter?.goBack()
    }
    
    func showError(msg: String) {
        self.notificationVC?.showErrorMessage(msg: msg)
    }
    
    func openLoginVC(phone: String) {
        self.notificationRouter?.openLoginVC(phone: phone)
    }
    
    func setNews(news: [News]) {
        self.notificationVC?.setNews(news: news)
    }
}
