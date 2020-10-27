//
//  Paper.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Paper: UIView {
    
    var radius: CGFloat = 12.0 {
        didSet {
            theShadowLayer.cornerRadius = self.radius
        }
    }
    
    private lazy var theShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.insertSublayer(theShadowLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()        
        self.theShadowLayer.frame = self.bounds
        self.theShadowLayer.fillColor = UIColor.white.cgColor
//        let mask = CAShapeLayer()
//        let path = UIBezierPath.init(
//            roundedRect: self.bounds,
//            byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
//            cornerRadii: CGSize.init(width: radius, height: radius)
//        )

        self.theShadowLayer.path = UIBezierPath.init(roundedRect: frame, cornerRadius: self.radius).cgPath
//        self.theShadowLayer.path = path.cgPath
//        self.theShadowLayer.mask = mask
        self.theShadowLayer.fillColor = UIColor.white.cgColor
        self.theShadowLayer.shadowColor = UIColor.black.cgColor
        self.theShadowLayer.shadowRadius = 6
        self.theShadowLayer.shadowOpacity = Float.init(0.06)
        self.theShadowLayer.shadowOffset = CGSize.init(width: 0.0, height: 4.0)
    }
    
}
