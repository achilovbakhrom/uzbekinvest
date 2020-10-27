//
//  OutlinedButton.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 10/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OutlinedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1.3
        self.layer.borderColor = Colors.primaryGreen.cgColor
        self.setTitleColor(Colors.primaryGreen, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.borderWidth = 1.3
        self.layer.borderColor = Colors.primaryGreen.cgColor
        self.setTitleColor(Colors.primaryGreen, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.masksToBounds = true
    }
    
}
