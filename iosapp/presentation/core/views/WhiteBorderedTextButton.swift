//
//  WhiteBorderedTextButton.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class WhiteBorderedTextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.layer.borderColor = UIColor.white.cgColor;
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
        self.setTitleColor(UIColor.white, for: .normal)        
    }
    
    func unselect() {
        self.layer.opacity = 0.5
    }
    
    func select() {
        self.layer.opacity = 1.0
    }
    
}
