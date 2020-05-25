//
//  IncidentsLocationMapView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class IncidentsLocationMapView: UIView, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    var annoation = MKPointAnnotation()
    
    var onLocationChange: ((Double, Double) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPresss(gestureRecognizer:)))
        
        lpgr.minimumPressDuration = 1.2
        self.mapView.addGestureRecognizer(lpgr)
        
        
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
        
        
//        annoation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 10, longitude: location.coordinate.longitude + 10)
//        annoation.title = "London"
//        self.mapView.addAnnotation(annoation)
    }
    
    @objc private func handleLongPresss(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        self.mapView.removeAnnotation(annoation)
        let point = gestureRecognizer.location(in: mapView)
        let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
        self.annoation.coordinate = coordinate
        self.mapView.addAnnotation(annoation)
        self.onLocationChange?(coordinate.longitude, coordinate.latitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location: \(location.coordinate.latitude)")
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            onLocationChange?(location.coordinate.longitude, location.coordinate.latitude)
            
            self.mapView.setRegion(region, animated: true)
        }
    }
    
}
