//
//  CenterMenu.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class CenterMenuView: UIView {
    
    private var firstTime = true
    
    private lazy var centerMenus: Paper = {
        let view = Paper(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.radius = 12.0
        return view
    }()
    
    private lazy var centerMenuConent: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
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
        self.addSubview(centerMenus)
    }
    
    var onCheckOrder: (() -> Void)? = nil
    var onIncident: (() -> Void)? = nil
    var onSupport: (() -> Void)? = nil
    
    @objc
    private func onCheckOrderAction(gesture: UITapGestureRecognizer) {
        self.onCheckOrder?()
    }
    
    @objc
    private func onIncidentAction(gesture: UITapGestureRecognizer) {
        self.onIncident?()
    }
    
    @objc
    private func onSupportAction(gesture: UITapGestureRecognizer) {
        self.onSupport?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstTime {
            NSLayoutConstraint.activate([
                centerMenus.leadingAnchor.constraint(equalTo: leadingAnchor),
                centerMenus.topAnchor.constraint(equalTo: topAnchor),
                centerMenus.trailingAnchor.constraint(equalTo: trailingAnchor),
                centerMenus.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            self.bringSubviewToFront(centerMenus)
            
            self.centerMenus.addSubview(self.centerMenuConent)
            
            self.centerMenuConent.backgroundColor = .white
            NSLayoutConstraint.activate([
                self.centerMenuConent.leadingAnchor.constraint(equalTo: self.centerMenus.leadingAnchor),
                self.centerMenuConent.topAnchor.constraint(equalTo: self.centerMenus.topAnchor),
                self.centerMenuConent.widthAnchor.constraint(equalTo: self.centerMenus.widthAnchor),
                self.centerMenuConent.heightAnchor.constraint(equalTo: self.centerMenus.heightAnchor)
            ])
            centerMenuConent.layer.cornerRadius = 8

            let viewHeight = self.bounds.height
            let viewWidth = self.bounds.width/3

            let view1 = UIView(frame: .zero)
            view1.translatesAutoresizingMaskIntoConstraints = false
            view1.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
            view1.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
            view1.isUserInteractionEnabled = true
            view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCheckOrderAction(gesture:))))
            var topAnchor: CGFloat = 0.0
            if isIPhone4OrNewer() {
                topAnchor = 14.0
            } else if isIPhoneSE() {
                topAnchor = 15.0
            } else if isIPhonePlus() {
                topAnchor = 17.0
            } else {
                topAnchor = 17.0
            }
            
            let image1 = UIImageView(image: UIImage(named: "polis-checked"))
            image1.translatesAutoresizingMaskIntoConstraints = false
            view1.addSubview(image1)
            NSLayoutConstraint.activate([
                image1.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
                image1.topAnchor.constraint(equalTo: view1.topAnchor, constant: topAnchor)
            ])
            
            let label1 = UILabel(frame: .zero)
            label1.translatesAutoresizingMaskIntoConstraints = false
            label1.text = "check_police".localized()
            label1.numberOfLines = 2
            
            if isIPhone4OrNewer() {
                label1.font = UIFont.init(name: "Roboto-Regular", size: 10)
            } else if isIPhoneSE() {
                label1.font = UIFont.init(name: "Roboto-Regular", size: 11)
            } else if isIPhonePlus() {
                label1.font = UIFont.init(name: "Roboto-Regular", size: 12)
            } else {
                label1.font = UIFont.init(name: "Roboto-Regular", size: 12)
            }
            
            label1.textAlignment = .center
            label1.isUserInteractionEnabled = true
            view1.addSubview(label1)
            NSLayoutConstraint.activate([
                label1.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
                label1.topAnchor.constraint(equalTo: image1.bottomAnchor, constant: 10)
            ])

            let view2 = UIView(frame: .zero)
            view2.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
            view2.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
            let image2 = UIImageView(image: UIImage(named: "polis-warning"))
            image2.translatesAutoresizingMaskIntoConstraints = false
            view2.addSubview(image2)
            NSLayoutConstraint.activate([
                image2.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
                image2.topAnchor.constraint(equalTo: view2.topAnchor, constant: topAnchor)
            ])
            let label2 = UILabel(frame: .zero)
            label2.translatesAutoresizingMaskIntoConstraints = false
            label2.text = "incident".localized()
            label2.numberOfLines = 2
            if isIPhone4OrNewer() {
                label2.font = UIFont.init(name: "Roboto-Regular", size: 10)
            } else if isIPhoneSE() {
                label2.font = UIFont.init(name: "Roboto-Regular", size: 11)
            } else if isIPhonePlus() {
                label2.font = UIFont.init(name: "Roboto-Regular", size: 12)
            } else {
                label2.font = UIFont.init(name: "Roboto-Regular", size: 12)
            }
            label2.textAlignment = .center
            view2.addSubview(label2)
            NSLayoutConstraint.activate([
                label2.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
                label2.topAnchor.constraint(equalTo: image2.bottomAnchor, constant: 10)
            ])
            view2.isUserInteractionEnabled = true
            view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onIncidentAction(gesture:))))
            
            let view3 = UIView(frame: .zero)
            view3.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
            view3.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
            let image3 = UIImageView(image: UIImage(named: "polis-question"))
            image3.translatesAutoresizingMaskIntoConstraints = false
            view3.addSubview(image3)
            NSLayoutConstraint.activate([
                image3.centerXAnchor.constraint(equalTo: view3.centerXAnchor),
                image3.topAnchor.constraint(equalTo: view3.topAnchor, constant: topAnchor)
            ])
            let label3 = UILabel(frame: .zero)
            label3.translatesAutoresizingMaskIntoConstraints = false
            label3.text = "support".localized()
            label3.numberOfLines = 2
            if isIPhone4OrNewer() {
                label3.font = UIFont.init(name: "Roboto-Regular", size: 10)
            } else if isIPhoneSE() {
                label3.font = UIFont.init(name: "Roboto-Regular", size: 11)
            } else if isIPhonePlus() {
                label3.font = UIFont.init(name: "Roboto-Regular", size: 12)
            } else {
                label3.font = UIFont.init(name: "Roboto-Regular", size: 12)
            }
            label3.textAlignment = .center
            label3.isUserInteractionEnabled = true
            view3.isUserInteractionEnabled = true
            view3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSupportAction(gesture:))))
            view3.addSubview(label3)
            NSLayoutConstraint.activate([
                label3.centerXAnchor.constraint(equalTo: view3.centerXAnchor),
                label3.topAnchor.constraint(equalTo: image3.bottomAnchor, constant: 10)
            ])

            self.centerMenuConent.addArrangedSubview(view1)
            let div1 = UIView(frame: .zero)
            div1.backgroundColor = Colors.pageIndicatorGray
            NSLayoutConstraint.activate([
                div1.widthAnchor.constraint(equalToConstant: 1),
                div1.heightAnchor.constraint(equalToConstant: viewHeight)
            ])

            self.centerMenuConent.addArrangedSubview(div1)
            self.centerMenuConent.addArrangedSubview(view2)
            let div2 = UIView(frame: .zero)
            div2.backgroundColor = Colors.pageIndicatorGray
            NSLayoutConstraint.activate([
                div2.widthAnchor.constraint(equalToConstant: 1),
                div2.heightAnchor.constraint(equalToConstant: viewHeight)
            ])
            self.centerMenuConent.addArrangedSubview(div2)
            self.centerMenuConent.addArrangedSubview(view3)
            firstTime = false
        }
    }
}
