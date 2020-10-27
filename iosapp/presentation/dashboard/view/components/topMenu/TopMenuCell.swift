//
//  TopMenuCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class TopMenuCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textColor = Colors.pageIndicatorGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cView: UIView = {
        let view = UIView.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var onCellClick: (() -> Void)? = nil
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {

        let height = UIScreen.main.bounds.height*0.05
        self.contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.contentView.addSubview(cView)

        var marginTop: CGFloat = 10.0
        
        if isIPhoneX() || isIPhoneXOrHigher() {
            marginTop = 20.0
        }
        

        self.leadingConstraint = self.cView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6)
        NSLayoutConstraint.activate([
            leadingConstraint,
            self.cView.heightAnchor.constraint(equalToConstant: height*0.8),
            self.cView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: marginTop)
        ])

        
        self.cView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 24),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.cView.trailingAnchor, constant: -24),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.cView.centerYAnchor)
        ])
        self.trailingConstraint = self.cView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6)
        self.trailingConstraint.isActive = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
        self.cView.layer.cornerRadius = height * 0.4
        self.cView.layer.masksToBounds = true
        self.cView.layer.borderWidth = 1.0
    }
    
    @objc
    private func clicked() {
        if let v = onCellClick {
            v()
        }
    }
    
    public func setTitle(title: String, isFirst: Bool, isLast: Bool) {
        self.titleLabel.text = title
        if isFirst {
            leadingConstraint.constant = 31
        } else {
            leadingConstraint.constant = 6
        }

        if isLast {
            self.trailingConstraint.constant = -31
        } else {
            self.trailingConstraint.constant = -6
        }
    }
    
    public func select() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.textColor = Colors.primaryGreen
            self.cView.layer.borderColor = Colors.primaryGreen.cgColor
        }
        
    }
    
    public func unselect() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.textColor = Colors.pageIndicatorGray
            self.cView.layer.borderColor = Colors.pageIndicatorGray.cgColor
        }
    }
    
}
