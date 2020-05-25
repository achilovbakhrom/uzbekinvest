//
//  MapVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentLocationMapVC: UIViewController {
    
    var mapView: IncidentsLocationMapView = IncidentsLocationMapView.fromNib()
    var onLocationChange: ((Double, Double) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.mapView.onLocationChange = onLocationChange
    }
    
    
}
