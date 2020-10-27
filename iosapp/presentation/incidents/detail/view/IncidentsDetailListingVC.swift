//
//  IncidentsDetailListing.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentsDetailListingVC: BaseWithLeftCirclesVC {
    
    private lazy var incidentListingView: IncidentDetailListingView = IncidentDetailListingView.fromNib()
    private lazy var incidentsDetailPresenter = self.presenter as? IncidentsDetailPresenter
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    var isOffline = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.incidentListingView.translatesAutoresizingMaskIntoConstraints = false
        self.incidentListingView.backgroundColor = .clear
        self.view.addSubview(incidentListingView)
        NSLayoutConstraint.activate([
            self.incidentListingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.incidentListingView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 10),
            self.incidentListingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.incidentListingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        incidentListingView.onAddNewPolis = {            
            self.incidentsDetailPresenter?.openInsuranceListVC()
        }
        
        incidentListingView.onPolisItemClicked = {
            self.incidentsDetailPresenter?.openAddEditVC(orderId: $0, productCode: $1, isOffline: self.isOffline)
        }
        
        incidentListingView.onAllButton = {
            self.isOffline = 0
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
                break
            case .online(.wwan), .online(.wiFi):
                self.incidentsDetailPresenter?.fetchIncidents()
                break
            }
        }
        
        incidentListingView.onPinflButton = {
            self.isOffline = 1
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
                break
            case .online(.wwan), .online(.wiFi):
                self.incidentsDetailPresenter?.fetchPinflOrders()
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
                self.incidentsDetailPresenter?.fetchIncidents()
            case .online(.wiFi):
                self.incidentsDetailPresenter?.fetchIncidents()
            }
        }
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.incidentsDetailPresenter?.fetchIncidents()
            break
        }
        
        self.backButtonClicked = {
            self.setTabBarHidden(false)
            self.incidentsDetailPresenter?.goBack()
        }
        self.setTabBarHidden(true)
        
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
            if show == false { self.incidentsDetailPresenter?.fetchIncidents() }
        }
    }
    
    func setInsurances(insurances: [MyInsurance]) {
        incidentListingView.insurances = insurances
    }
    
    func setLoading(isLoading: Bool) {
        self.incidentListingView.isLoading = isLoading
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let f = self.tabBarController?.tabBar.frame {
            let tabBarHeight = f.height;
            let screenHeight = UIScreen.main.bounds.height;
            if f.origin.y + tabBarHeight < screenHeight {
                self.tabBarController?.tabBar.frame = CGRect(x: f.origin.x, y: screenHeight, width: f.width, height: f.height)
            }
        }
    }
    
}
