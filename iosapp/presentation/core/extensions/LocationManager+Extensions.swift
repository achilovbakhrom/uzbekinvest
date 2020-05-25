//
//  LocationManager+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import CoreLocation

// MARK: - Get Placemark
extension CLLocationManager {
    
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
