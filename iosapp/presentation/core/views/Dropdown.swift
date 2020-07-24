//
//  Dropdown.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class DDown: DropDown {
    private var underscoreLayer: CALayer! = nil
    private var floatTextLayer: CATextLayer! = nil
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.borderStyle = .none
        self.font = UIFont.init(name: "Roboto-Regular", size: 20)
        self.textColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0)        
        self.rowHeight = 30
        self.selectedRowColor = Colors.primaryGreen.withAlphaComponent(0.5)
        self.arrowColor = Colors.primaryGreen
        self.arrowSize = 10        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if underscoreLayer == nil {
            underscoreLayer = CALayer()
            underscoreLayer.backgroundColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.6).cgColor
            underscoreLayer.frame = CGRect(x: 0, y: self.frame.height + 4.0, width: self.frame.width, height: 1.0)
            self.layer.addSublayer(underscoreLayer)
        }
        
        if floatTextLayer == nil {
            floatTextLayer = CATextLayer()
            floatTextLayer.font = UIFont.init(name: "Roboto-Regular", size: 15)
            floatTextLayer.fontSize = 13
            floatTextLayer.foregroundColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0).cgColor
            floatTextLayer.contentsScale = UIScreen.main.scale
            floatTextLayer.frame = CGRect(x: 3, y: -24, width: self.frame.width, height: 20)
            self.layer.addSublayer(floatTextLayer)
        }
    }
}

