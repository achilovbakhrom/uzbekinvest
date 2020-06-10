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
    private lazy var incidentsListView: IncidentsListView = IncidentsListView.fromNib()
    
    private lazy var incidentPresenter = self.presenter as? IncidentsListingPresenter
    
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
            
        }
        
        self.header.onChat = {
            self.navigationController?.pushViewController(ChatVC(), animated: true)
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
        
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.loadingView.layer.opacity = 0.0
        self.updateList()        
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
