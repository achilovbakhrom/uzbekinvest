//
//  DirectionsVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DirectionsVC: UIViewController, MKMapViewDelegate {
    
    var directionView: DirectionsView = DirectionsView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(directionView)
        directionView.onBackClicked = {
            self.dismiss(animated: true, completion: nil)
        }
        NSLayoutConstraint.activate([
            self.directionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.directionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.directionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.directionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        directionView.mapView.delegate = self
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Times Square"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        directionView.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.directionView.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.directionView.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Colors.primaryGreen
        renderer.lineWidth = 4.0
        return renderer
    }
    
}
