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
    @IBOutlet weak var descriptionLabel: UILabel!
    var onBack: (() -> Void)? = nil
    @IBOutlet weak var requestSent: UILabel!
    @IBOutlet weak var requestSentDesc: UILabel!
    
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var acceptedDescLabel: UILabel!
    
    @IBOutlet weak var documentsLabel: UILabel!
    @IBOutlet weak var documentsDesc: UILabel!
    
    
    @IBOutlet weak var decidedLabel: UILabel!
    @IBOutlet weak var decidedDescription: UILabel!
    
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var doneDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusContainer.layer.cornerRadius = 14.0
        self.statusContainer.layer.masksToBounds = true        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        onBack?()
    }
    
    func setDescription(desc: String) {
        self.descriptionLabel.text = desc
    }
    
    
    
}
