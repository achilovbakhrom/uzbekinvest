//
//  WhiteCircledBackVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit


class WhiteCircledBackVC: UIViewController {
    
    var circleView: UIView! = nil
    var imageView: UIButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var circleSide: CGFloat = 0.0
        var arrowWidth: CGFloat = 0.0
        var arrowHeight: CGFloat = 0.0
        
        
        if isIPhone4OrNewer() {
            circleSide = 30
            arrowWidth = 30.0
            arrowHeight = 30.0
        } else if isIPhoneSE() {
            circleSide = 36
            arrowWidth = 20.0
            arrowHeight = 14.0
        } else if isIPhonePlus() {
            circleSide = 44
            arrowWidth = 30.0
            arrowHeight = 30.0
        } else {
            circleSide = 54
            arrowWidth = 30.0
            arrowHeight = 30.0
        }
        
        circleView = UIView(frame: .zero)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = Colors.backArrowBgColor;
        circleView.layer.cornerRadius = circleSide/2.0
        circleView.layer.masksToBounds = true
        imageView = UIButton.init(frame: .zero)
        imageView.setImage(UIImage(named: "back-arrow"), for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(circleView)
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: circleSide),
            circleView.heightAnchor.constraint(equalToConstant: circleSide),
            circleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            circleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15),
            
            imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: arrowWidth),
            imageView.heightAnchor.constraint(equalToConstant: arrowHeight)
        ])
        
        imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(onBackPressed)))
        
        
    }
    
    @objc
    func onBackPressed() {}
}
