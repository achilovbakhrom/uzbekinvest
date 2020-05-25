//
//  OsageConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class BaseWithRightGreenCirclesVC: BaseViewImpl {
    
    var backButton: UIButton!
    
    var backButtonClicked: (() -> Void)? = nil
    var circle1: UIImageView!
    var circle2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        circle1 = UIImageView(image: UIImage(named: "green-big-circle"))
        circle1.contentMode = .scaleAspectFill
        circle1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(circle1)
        NSLayoutConstraint.activate([
            circle1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            circle1.topAnchor.constraint(equalTo: self.view.topAnchor),
            circle1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.436),
            circle1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.243)
        ])
        
        circle2 = UIImageView(image: UIImage(named: "green-small-circle"))
        circle2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(circle2)
        NSLayoutConstraint.activate([
            circle2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            circle2.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            circle2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.view.bounds.width*0.3),
            circle2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height*0.16)
        ])
        
        backButton = UIButton(frame: .zero)
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backClicked)))
        
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 23),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28),
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 54)
        ])
        
    }
    
    @objc
    private func backClicked() {
        if let v = backButtonClicked { v() }
    }
}
