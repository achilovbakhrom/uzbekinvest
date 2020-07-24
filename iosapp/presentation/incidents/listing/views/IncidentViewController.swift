//
//  IncidentViewController.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class IncidentViewController: BaseViewImpl {
    
    private lazy var header: IncidentHeaderView = IncidentHeaderView.fromNib()
    private lazy var empty: IncidentEmptyView = IncidentEmptyView.fromNib()
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    private lazy var incidentsListView: IncidentsListView = IncidentsListView.fromNib()
    private lazy var incidentPresenter = self.presenter as? IncidentsListingPresenter
    private var v: CallbackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isTranslucent = false
        self.view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        var multiplayer: CGFloat = 0.0
        
        if isIPhone4OrNewer() {
            multiplayer = 0.4
        } else if isIPhoneSE() {
            multiplayer = 0.4
        } else if isIPhonePlus() {
            multiplayer = 0.4
        } else {
            multiplayer = 0.4
        }
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            header.topAnchor.constraint(equalTo: self.view.topAnchor),
            header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: multiplayer)
        ])        
        self.header.onSupportCall = {
            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        self.header.onCallback = {
            let alertC = UIAlertController.init(title: "", message: "\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)            
            self.v = CallbackView.init(frame: .zero)
            self.v.translatesAutoresizingMaskIntoConstraints = false
            self.v.onCallback = {
                self.incidentPresenter?.callback(phone: self.v.phone)
            }
            self.v.onCancel = {
                self.dismiss(animated: true, completion: nil)
            }
            alertC.view.backgroundColor = .white
            alertC.view.layer.cornerRadius = 10
            alertC.view.layer.masksToBounds = true
            alertC.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
            
            alertC.view.addSubview(self.v)
            NSLayoutConstraint.activate([
                self.v.widthAnchor.constraint(equalTo: alertC.view.widthAnchor),
                self.v.leadingAnchor.constraint(equalTo: alertC.view.leadingAnchor),
                self.v.topAnchor.constraint(equalTo: alertC.view.topAnchor),
                self.v.trailingAnchor.constraint(equalTo: alertC.view.trailingAnchor),
                self.v.bottomAnchor.constraint(equalTo: alertC.view.bottomAnchor),
                alertC.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9)
            ])
            
            self.present(alertC, animated: true)
        }
        
        
        
        self.header.onChat = {
            self.incidentPresenter?.openChatVC()
//            self.navigationController?.pushViewController(ChatVC(), animated: true)
        }
        
        self.view.addSubview(empty)
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.onNewAdd = {
            self.incidentPresenter?.openDetailPage()
        }
        
        NSLayoutConstraint.activate([
            empty.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            empty.topAnchor.constraint(equalTo: self.header.bottomAnchor),
            empty.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            empty.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.addSubview(incidentsListView)
        incidentsListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            incidentsListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            incidentsListView.topAnchor.constraint(equalTo: self.header.bottomAnchor),
            incidentsListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            incidentsListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        incidentsListView.onAddIncident = {
            self.incidentPresenter?.openDetailPage()
        }
        incidentsListView.onIncidentSelect = {
            self.incidentPresenter?.openIncidentInfo(incident: $0)
        }
        
        self.view.addSubview(loadingView)
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.loadingView.layer.opacity = 0.0
        self.setupNoInternetView()
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.updateList()
            break
        }
        self.view.bringSubviewToFront(self.loadingView)
    }
    
    func setCallbackLoading(isLoading: Bool) {
        self.v.button.isLoading = isLoading
    }
    
    @objc
    private func closeAlert(_ gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dissmissAlert(completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: completion)
    }
    
    func setupNoInternetView() {
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
                self.updateList()
            case .online(.wiFi):
                self.updateList()
            }
        }
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setMode(isEmpty: Bool) {
        self.empty.isHidden = !isEmpty
        self.incidentsListView.isHidden = isEmpty
    }
    
    func updateList() {
        self.incidentPresenter?.fetchIncidents()
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
    }
    
    func setIncidentsList(incidents: [Incident]) {
        incidentsListView.incidents = incidents
    }
    
}
