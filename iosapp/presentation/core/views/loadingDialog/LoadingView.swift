//
//  LoadingView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

class LoadingView: UIView {
    
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    func startAnimating() {
        loadingIndicator.startAnimating()
    }
    
    func stopAnimating() {
        loadingIndicator.stopAnimating()
    }
    
}
