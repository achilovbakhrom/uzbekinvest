//
//  PhoneTextField.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

import UIKit

class PhoneTextField: TextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.maskExpression = "+998 9{d} {ddd} {dd} {dd}"
        self.maskTemplate = " "
        self.keyboardType = .phonePad
    }
    
}
