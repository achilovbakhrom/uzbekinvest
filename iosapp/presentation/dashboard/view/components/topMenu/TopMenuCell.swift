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
    
    public var onCellClick: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.05),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
    }
    
    @objc
    private func clicked() {
        if let v = onCellClick {
            v()
        }
    }
    
    public func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    public func select() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.textColor = Colors.primaryGreen
        }
        
    }
    
    public func unselect() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.textColor = Colors.pageIndicatorGray
        }        
    }
    
}
