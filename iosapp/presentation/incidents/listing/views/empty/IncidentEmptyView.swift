//
//  IncidentEmptyView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentEmptyView: UIView {
    
    var onNewAdd: (() -> Void)? = nil
    
    @IBAction func onAddButtonClicked(_ sender: Any) {
        self.onNewAdd?()
    }
    
}
