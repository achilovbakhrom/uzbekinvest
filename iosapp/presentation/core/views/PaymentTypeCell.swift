//
//  PaymentTypeCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class PaymentTypeCell: UICollectionViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 12.0)
        label.textColor = UIColor.init(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.layer.borderColor = Colors.primaryGreen.cgColor
        view.layer.borderWidth = 0.0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var onClick: (() -> Void)? = nil
    var leadingConstraint: NSLayoutConstraint!
    var hasTopMargin = false
    private func setup() {
        self.contentView.addSubview(self.view)
        leadingConstraint = self.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        NSLayoutConstraint.activate([
            leadingConstraint,
            self.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: hasTopMargin ? 10 : 0),
            self.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.37),
            self.view.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCellClick)))
        
        self.view.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            self.iconImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 13),
            self.iconImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 41.0),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 41.0)
        ])
        
        self.view.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 10),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10)
        ])
    }
    @objc
    private func onCellClick() {
        if let b = self.onClick {
            b()
        }
    }
    
    func setData(model: PaymentTypeCellModel) {
        self.iconImageView.image = UIImage(named: model.icon)
        self.titleLabel.text = model.title
        if model.selected {
            UIView.animate(withDuration: 0.2) {
                self.view.layer.borderWidth = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.view.layer.borderWidth = 0.0
            }
        }
        if model.isFirst {
            leadingConstraint.constant = 31
        } else {
            leadingConstraint.constant = 0
        }
    }
}

struct PaymentTypeCellModel {
    var icon: String
    var title: String
    var selected: Bool
    var isFirst: Bool
}
