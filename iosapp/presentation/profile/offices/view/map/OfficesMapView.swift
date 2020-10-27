//
//  OfficesMapView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/20/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OfficesMapView: UIView, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
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

        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
    }
    
    func setOfficesList(officesList: Array<Office>) {
        officesList.forEach { office in
            if let long = office.longitude, !long.isEmpty, let lat = office.latitude, !lat.isEmpty {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(long) ?? 0.0)
                office.translates?.forEach({ t in
                    if t?.lang == translateCode {
                        annotation.title = t?.address
                        annotation.subtitle = t?.workTime
                    }
                })
                
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
}
