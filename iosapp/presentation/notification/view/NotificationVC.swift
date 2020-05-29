//
//  NotificationVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class NotificationVC: BaseViewImpl {
    
    var notificationView: NotificationView = NotificationView.fromNib()
    var loadingView: LoadingView = LoadingView.fromNib()
    var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    private lazy var notificationPresenter = self.presenter as? NotificationPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(notificationView)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.notificationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.notificationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.notificationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.notificationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        notificationView.onBack = { self.notificationPresenter?.goBack() }
        
        self.setTabBarHidden(true)
        
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        loadingView.layer.opacity = 0.0
        
        self.view.addSubview(noInternetView)
        noInternetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noInternetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.noInternetView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noInternetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.noInternetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        noInternetView.layer.opacity = 0.0
        
        noInternetView.onRepeatClicked = {
            self.showNoInternetView(show: false)
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
                
                break
            case .online(.wwan), .online(.wiFi):
                break
            }
        }
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.notificationPresenter?.fetchNotifications()
            break
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
        
    }
    
    func setNotifications(notifications: [NotificationModel]) {
        self.notificationView.setNotifications(notifications: notifications)
    }
    
    func setNews(news: [News]) {
        self.notificationView.setNews(news: news)
    }
    
}
