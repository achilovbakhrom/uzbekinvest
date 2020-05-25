//
//  WelcomeVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class BaseGreenVC: BaseViewImpl {
    
    private var gradient: CAGradientLayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (gradient == nil) {
            self.gradient = Colors().bigGreenBG
            self.gradient.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(gradient, at: 0)
            
            let circle1 = UIImageView(image: UIImage(named: "circle1"))
            circle1.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(circle1)
            
            let circle2 = UIImageView(image: UIImage(named: "circle2"))
            circle2.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(circle2)
            
            let circle3 = UIImageView(image: UIImage(named: "circle3"))
            circle3.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(circle3)

            NSLayoutConstraint.activate([
                // top left circle
                circle1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                circle1.topAnchor.constraint(equalTo: self.view.topAnchor),

                circle2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
                circle2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
                circle2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -111),
                circle2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120),
                
                circle3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                circle3.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        }        
    }
    
}
