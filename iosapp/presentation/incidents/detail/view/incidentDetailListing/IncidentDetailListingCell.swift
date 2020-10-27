//
//  IncidentDetailListingCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentDetailListingCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.font = UIFont.init(name: "Roboto-Bold", size: 18.0)
        return label
    }()
    
    private lazy var polisTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 16.0)
        label.text = "policy_number".localized()
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        return label
    }()
    
    private lazy var polisAmount: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Bold", size: 16.0)
        return label
    }()
    
    private lazy var polisSumTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 16.0)
        label.text = "policy_amount".localized()
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        return label
    }()
    
    private lazy var polisSum: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Bold", size: 16.0)
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("select".localized(), for: .normal)
        button.setTitleColor(Colors.primaryGreen, for: .normal)
        return button
    }()
    
    private lazy var div: UIView  = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    var bottomConstraint: NSLayoutConstraint!
    
    private func setupUI() {
        self.contentView.addSubview(titleLabel)        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
        ])
        
        self.contentView.addSubview(polisTitle)
        NSLayoutConstraint.activate([
            self.polisTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.polisTitle.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15)
        ])
        
        self.contentView.addSubview(polisAmount)
        NSLayoutConstraint.activate([
            self.polisAmount.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.polisAmount.centerYAnchor.constraint(equalTo: self.polisTitle.centerYAnchor),
            self.polisAmount.leadingAnchor.constraint(greaterThanOrEqualTo: self.polisTitle.trailingAnchor, constant: 8)
        ])
        
        self.contentView.addSubview(polisSumTitle)
        NSLayoutConstraint.activate([
            self.polisSumTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.polisSumTitle.topAnchor.constraint(equalTo: self.polisTitle.bottomAnchor, constant: 10)
        ])
        
        self.contentView.addSubview(polisSum)
        NSLayoutConstraint.activate([
            self.polisSum.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.polisSum.centerYAnchor.constraint(equalTo: self.polisSumTitle.centerYAnchor),
            self.polisSum.leadingAnchor.constraint(greaterThanOrEqualTo: self.polisSumTitle.trailingAnchor, constant: 10)
        ])
        
        self.contentView.addSubview(selectButton)
        NSLayoutConstraint.activate([
            self.selectButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.selectButton.topAnchor.constraint(equalTo: self.polisSumTitle.bottomAnchor, constant: 5)
        ])
        
        self.contentView.addSubview(div)
        NSLayoutConstraint.activate([
            self.div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.div.topAnchor.constraint(equalTo: self.selectButton.bottomAnchor, constant: 14),
            self.div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.div.heightAnchor.constraint(equalToConstant: 1.0)
            
        ])
        bottomConstraint = self.div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        bottomConstraint.isActive = true
    }
    
    func setData(insurance: MyInsurance, isLast: Bool) {
        insurance.product?.translates?.forEach({ (t) in
            if t?.lang == translateCode {
                self.titleLabel.text = t?.name
            }
        })
        
        self.polisAmount.text = "\(insurance.id)"
        self.polisSum.text = "\(insurance.insuranceAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        bottomConstraint.constant = isLast ? -80 : 0        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
