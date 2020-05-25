//
//  Button.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class Button: UIButton {
        
    var loadingIndicator: NVActivityIndicatorView!
    private var tempTitle: String?
    var gradient: CAGradientLayer!
    private var theShadowLayer: CAShapeLayer?
    
    
    var isLoading: Bool = false {
        didSet {
            self.handleLoading()
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()        
    }
    
    private func setup() {
        
        gradient = CAGradientLayer()
        
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 16)

        loadingIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.bounds.height/2, height: self.bounds.height/2))
        loadingIndicator.type = .circleStrokeSpin
        self.addSubview(loadingIndicator)
        self.handleLoading()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingIndicator.frame = CGRect(
            x: self.bounds.width/2 - self.bounds.height/4,
            y: self.bounds.height/2 - self.bounds.height/4,
            width: self.bounds.height/2,
            height: self.bounds.height/2
        )
        gradient?.frame = self.bounds;
        gradient.cornerRadius = self.frame.height/2
        gradient.masksToBounds = true
        
        if self.theShadowLayer == nil {
            let rounding = CGFloat.init(22.0)

            let shadowLayer = CAShapeLayer.init()
            self.theShadowLayer = shadowLayer
            shadowLayer.path = UIBezierPath.init(roundedRect: bounds, cornerRadius: rounding).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor

            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowRadius = CGFloat.init(3.0)
            shadowLayer.shadowOpacity = Float.init(0.2)
            shadowLayer.shadowOffset = CGSize.init(width: 0.0, height: 4.0)

            self.layer.insertSublayer(shadowLayer, at: 0)
        }
        
        if !isLoading && isEnabled {
            enable()
        } else {
            disable()
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
        
    }
    
    func makeRedColor() {
        self.layer.insertSublayer(Colors().gr, at: 0)
    }
    
    private func handleLoading() {
        tempTitle = self.titleLabel?.text
        loadingIndicator.isHidden = !isLoading
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
        self.setTitle(isLoading ? "" : tempTitle, for: .normal)
        self.isEnabled = !isLoading
        if (isLoading) {
            disable()
        } else {
            enable()
        }
    }
    
    private func disable() {
        gradient.removeFromSuperlayer()
        gradient.makeGrayBg();
        self.layer.insertSublayer(gradient!, at: 0)
        
    }
    
    private func enable() {
        gradient.removeFromSuperlayer()
        gradient.makeGreenGradient();
        self.layer.insertSublayer(gradient!, at: 0)
        
    }
    
    
}
