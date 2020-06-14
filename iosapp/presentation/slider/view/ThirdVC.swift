//
//  ThirdVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class ThirdVC: WhiteCircledBackVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var goToPrevious: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isIPhone4OrNewer() {
            titleLabel.fontSize = 17.0
            descriptionLabel.fontSize = 14.0
        } else if isIPhoneSE() {
            titleLabel.fontSize = 18.0
            descriptionLabel.fontSize = 14.0
        } else if isIPhonePlus() {
            titleLabel.fontSize = 19.0
            descriptionLabel.fontSize = 16.0
        } else {
            titleLabel.fontSize = 20.0
            descriptionLabel.fontSize = 17.0
        }
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackPressed)))
        titleLabel.text = "slider_third".localized()
    }
    
    @objc
    override func onBackPressed() {
        if let v = goToPrevious {
            v()
        }
    }
}
