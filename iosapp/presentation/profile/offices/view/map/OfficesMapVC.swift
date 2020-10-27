//
//  MapVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/20/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class OfficesMapVC: BaseViewImpl {
    
    private lazy var officesMapView: OfficesMapView = OfficesMapView.fromNib()
    private lazy var noMapView: NoMapView = NoMapView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        officesMapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(officesMapView)
        NSLayoutConstraint.activate([
            self.officesMapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.officesMapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.officesMapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.officesMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        noMapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noMapView)        
        NSLayoutConstraint.activate([
            self.noMapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.noMapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noMapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.noMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        noMapView.onAgain = {
            self.checkPermission()
        }
        self.setMapMode(isMapMode: false, isAnimated: false)
        self.checkPermission()
    }
    
    func setOfficesList(officesList: Array<Office>) {
        self.officesMapView.setOfficesList(officesList: officesList)
    }
    
    private func checkPermission() {
        let status = CLLocationManager.authorizationStatus()
        let locationManager = CLLocationManager()
        switch status {
        case .notDetermined:
            noMapView.descriptionLabel.text = "your_aggreement".localized()
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            noMapView.descriptionLabel.text = "your_aggreement".localized()
            self.setMapMode(isMapMode: false)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            self.setMapMode(isMapMode: true)
            break
        default:
            break
        }

    }
    
    func setMapMode(isMapMode: Bool, isAnimated: Bool = true) {
        if isAnimated {
            UIView.animate(withDuration: 0.2) {
                self.noMapView.layer.opacity = isMapMode ? 0.0 : 1.0
            }
        } else {
            self.noMapView.isHidden = isMapMode
        }
    }
}
