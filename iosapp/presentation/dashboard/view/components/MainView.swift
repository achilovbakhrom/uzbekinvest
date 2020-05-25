//
//  MainView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
    
    private var topMenuHeight: CGFloat {
        var topSpace: CGFloat = 0.0
        if isIPhoneXOrHigher() { topSpace = 44.0 }
        return 0.05*UIScreen.main.bounds.height + topSpace;
    }
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var headerTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 22)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    lazy var headerContentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Light", size: 18)
        label.numberOfLines = 4
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerView)        
        self.headerView.addSubview(self.headerTitleLabel)
        self.headerView.addSubview(self.headerContentLabel)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(headerView)
        self.headerView.addSubview(self.headerTitleLabel)
        self.headerView.addSubview(self.headerContentLabel)
        self.setup()
    }
    
    
    private func setup() {
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        var topMargin: CGFloat = 0.0
        var btwMargin: CGFloat = 0.0
        if isIPhone4OrNewer() {
            topMargin = 20.0
            btwMargin = 10.0
            self.headerTitleLabel.fontSize = 18.0
            self.headerContentLabel.fontSize = 15.0
        } else if isIPhoneSE() {
            topMargin = 35.0
            btwMargin = 14.0
            self.headerTitleLabel.fontSize = 18.0
            self.headerContentLabel.fontSize = 15.0
        } else if isIPhonePlus() {
            topMargin = 45.0
            btwMargin = 18.0
            self.headerTitleLabel.fontSize = 21.0
            self.headerContentLabel.fontSize = 17.0
        } else {
            topMargin = 65.0
            btwMargin = 22.0
            self.headerTitleLabel.fontSize = 22.0
            self.headerContentLabel.fontSize = 18.0
        }
        
        NSLayoutConstraint.activate([
            headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31),
            headerTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31)
        ])
        
        NSLayoutConstraint.activate([
            headerContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31),
            headerContentLabel.topAnchor.constraint(equalTo: self.headerTitleLabel.bottomAnchor, constant: btwMargin),
            headerContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),
        ])
    }
    
}
