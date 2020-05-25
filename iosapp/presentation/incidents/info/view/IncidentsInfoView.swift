//
//  IncidentsInfoView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import StepIndicator

class IncidentsInfoView: UIView {
    
    
    @IBOutlet weak var incidentName: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var stepView: StepIndicatorView!
    @IBOutlet weak var incidentAmount: UILabel!
    var onBack: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusContainer.layer.cornerRadius = 11.0
        self.statusContainer.layer.masksToBounds = true
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        onBack?()
    }
}
