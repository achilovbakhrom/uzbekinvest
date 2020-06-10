//
//  CommentsVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class CommentsVC: BaseWithLeftCirclesVC {
    
    private lazy var commentsView: CommentsView = CommentsView.fromNib()
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    private var incidentsPresenter: IncidentsAddEditPresenter? {
        get {
            return self.presenter as? IncidentsAddEditPresenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(commentsView)
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.commentsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.commentsView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 15),
            self.commentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.commentsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        commentsView.onCommentsChange = {
            self.incidentsPresenter?.setComment(comment: $0)
        }
        
        self.backButtonClicked = {
            self.incidentsPresenter?.goBack()
        }
        
        commentsView.onCreateIncident = {
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
                break
            case .online(.wwan), .online(.wiFi):
                self.incidentsPresenter?.createIncident()
                break
            }
        }
        
        self.view.addSubview(self.noInternetView)
        self.noInternetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noInternetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.noInternetView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noInternetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.noInternetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.view.bringSubviewToFront(self.noInternetView)
        self.noInternetView.layer.opacity = 0.0
        self.noInternetView.onRepeatClicked = {
            self.showNoInternetView(show: false)
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
            case .online(.wwan):
                self.incidentsPresenter?.createIncident()
            case .online(.wiFi):
                self.incidentsPresenter?.createIncident()
            }
        }        
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setLoading(isLoading: Bool) {
        commentsView.createButton.isLoading = isLoading
    }
    
}
