//
//  IncidentHeaderView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentHeaderView: UIView {
    
    
    
    @IBOutlet weak var callOperatorConstraint: NSLayoutConstraint!
    @IBOutlet weak var callbackConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageConstraint: NSLayoutConstraint!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var callOperatorLabel: UILabel!
    @IBOutlet weak var callbackLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isIPhone4OrNewer() {
            callOperatorConstraint.constant = 0.40
            callbackConstraint.constant = 0.40
            messageConstraint.constant = 0.40
            titleLabel.fontSize = 15.0
            descLabel.fontSize = 12.0
            callOperatorLabel.fontSize = 10.0
            callbackLabel.fontSize = 10.0
            messageLabel.fontSize = 10.0
        } else if isIPhoneSE() {
            callOperatorConstraint.constant = 0.52
            callbackConstraint.constant = 0.52
            messageConstraint.constant = 0.52
            titleLabel.fontSize = 16.0
            descLabel.fontSize = 13.0
            callOperatorLabel.fontSize = 11.0
            callbackLabel.fontSize = 11.0
            messageLabel.fontSize = 11.0
        } else if isIPhonePlus() {
            callOperatorConstraint.constant = 0.55
            callbackConstraint.constant = 0.55
            messageConstraint.constant = 0.55
            titleLabel.fontSize = 18.0
            descLabel.fontSize = 14.0
            callOperatorLabel.fontSize = 13.0
            callbackLabel.fontSize = 13.0
            messageLabel.fontSize = 13.0
        } else {
            callOperatorConstraint.constant = 0.60
            callbackConstraint.constant = 0.60
            messageConstraint.constant = 0.60
            titleLabel.fontSize = 18.0
            descLabel.fontSize = 14.0
            callOperatorLabel.fontSize = 13.0
            callbackLabel.fontSize = 13.0
            messageLabel.fontSize = 13.0
        }
    }
}
