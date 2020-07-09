//
//  BaseWithLeftCirclesVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class BaseWithLeftCirclesVC: BaseViewImpl {
    
    var backButton: UIButton!
    
    var backButtonClicked: (() -> Void)? = nil
    var circle1: UIImageView!
    var circle2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        circle1 = UIImageView(image: UIImage(named: "gray-circle-1"))
        circle1.contentMode = .scaleAspectFill
        circle1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(circle1)
        NSLayoutConstraint.activate([
            circle1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            circle1.topAnchor.constraint(equalTo: self.view.topAnchor),
            circle1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.436),
            circle1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.243)
        ])
        
        circle2 = UIImageView(image: UIImage(named: "gray-circle-2"))
        circle2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(circle2)
        NSLayoutConstraint.activate([
            circle2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            circle2.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            circle2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.frame.width*0.3),
            circle2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height*0.16)
        ])
        
        backButton = UIButton(frame: .zero)
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backClicked)))
        
        var topMargin: CGFloat = 0.0
        if isIPhone4OrNewer() {
            topMargin = 18.0
        } else if isIPhoneSE() {
            topMargin = 30
        } else if isIPhonePlus() {
            topMargin = 54.0
        } else {
            topMargin = 54.0
        }
        
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 23),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28),
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topMargin)
        ])
    }
    
    @objc
    private func backClicked() {
        if let v = backButtonClicked { v() }
    }
    
}
