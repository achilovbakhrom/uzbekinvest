//
//  AboutUsView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class AboutUsView: UIView {
    
    @IBOutlet weak var aboutUsTextLabel: UILabel!
    var onBack: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        aboutUsTextLabel.text = "about_us_text".localized()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.onBack?()
    }
    
}
