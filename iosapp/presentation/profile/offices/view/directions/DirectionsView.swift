//
//  DirectionsView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DirectionsView: UIView {
    
    var onBackClicked: (() -> Void)? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func backButtonClickAction(_ sender: Any) {
        self.onBackClicked?()
    }
    
}
