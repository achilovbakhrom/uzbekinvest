//
//  OrangeButton.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit


class OrangeButton: UIButton {
        
    var gradient: CAGradientLayer!
    private var shadowLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var isChecked: Bool = false {
        didSet {
            self.setChecked(isChecked: self.isChecked)
        }
    }
    
    private func setup() {
        
        gradient = CAGradientLayer()
        gradient.cornerRadius = 8.0
        gradient.masksToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
        
        self.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 16)
        self.setTitleColor(.white, for: .normal)
    }
    
    private func setChecked(isChecked: Bool) {
        if isChecked {
            self.gradient.makeOrangeGrandient()
            self.shadowLayer?.opacity = 1.0
        } else {
            self.gradient.makeGrayBg()
            self.shadowLayer?.opacity = 0.0
        }
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient?.frame = self.bounds;
        if shadowLayer == nil {
            self.shadowLayer = CAShapeLayer.init()
            self.shadowLayer?.path = UIBezierPath.init(roundedRect: bounds, cornerRadius: 8.0).cgPath
            self.shadowLayer?.fillColor = UIColor.clear.cgColor
            self.shadowLayer?.shadowPath = shadowLayer?.path
            self.shadowLayer?.shadowRadius = CGFloat.init(3.0)
            self.shadowLayer?.shadowOpacity = Float.init(0.2)
            self.shadowLayer?.shadowColor = UIColor.init(red: 255.0/255.0, green: 177.0/255.0, blue: 53.0/255.0, alpha: 1.0).cgColor
            self.shadowLayer?.shadowOffset = CGSize.init(width: 0.0, height: 4.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
        
    }
    
}
