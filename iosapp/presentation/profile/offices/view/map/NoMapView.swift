//
//  NoMapView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/20/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class NoMapView: UIView {
    
    var onAgain: (() -> Void)? = nil
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func onAgainButtonClicked(_ sender: Any) {
        self.onAgain?()
    }
    
}
