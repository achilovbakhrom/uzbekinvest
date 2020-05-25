//
//  MapListDialogView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit


class MapListDialogView: UIView {
    
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchAddress: UILabel!
    @IBOutlet weak var workTime: UILabel!
    
    var onRouteBuild: (() -> Void)? = nil
    
    @IBAction func onBuildRouteClicked(_ sender: Any) {
        self.onRouteBuild?()
    }
    
}
