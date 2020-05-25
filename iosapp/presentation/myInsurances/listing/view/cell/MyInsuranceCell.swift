//
//  MyInsuranceCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyInsuranceCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var statusContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 11.6)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    private lazy var amountTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "insurance_amount".localized()
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "Roboto-Medium", size: 14.0)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var dateTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "date".localized()
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "Roboto-Medium", size: 14.0)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var cellDivider: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    private var myInsurance: MyInsurance!
    
    var onItemClick: ((MyInsurance) -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private var bottomConstraint: NSLayoutConstraint!
    
    private func setupUI() {
        self.contentView.addSubview(statusContainer)
        NSLayoutConstraint.activate([
            self.statusContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.statusContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.statusContainer.heightAnchor.constraint(equalToConstant: 30.0),
            self.statusContainer.widthAnchor.constraint(greaterThanOrEqualToConstant: 70)
        ])
        self.statusContainer.layer.cornerRadius = 15.0
        
        self.statusContainer.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            self.statusLabel.centerYAnchor.constraint(equalTo: self.statusContainer.centerYAnchor),
            self.statusLabel.trailingAnchor.constraint(equalTo: self.statusContainer.trailingAnchor, constant: -14),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.statusContainer.leadingAnchor, constant: 14)
        ])
        
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.statusContainer.leadingAnchor, constant: -10)
        ])
        
        self.contentView.addSubview(amountTitleLabel)
        NSLayoutConstraint.activate([
            self.amountTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.amountTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 22),
        ])
        
        self.contentView.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            self.amountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.amountLabel.centerYAnchor.constraint(equalTo: self.amountTitleLabel.centerYAnchor),
            self.amountLabel.leadingAnchor.constraint(equalTo: self.amountTitleLabel.trailingAnchor, constant: 10)
        ])
        
        self.contentView.addSubview(dateTitleLabel)
        NSLayoutConstraint.activate([
            self.dateTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.dateTitleLabel.topAnchor.constraint(equalTo: self.amountTitleLabel.bottomAnchor, constant: 12)
        ])
        self.contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.dateTitleLabel.centerYAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.dateTitleLabel.trailingAnchor, constant: 10)
        ])
        
        self.contentView.addSubview(cellDivider)
        self.bottomConstraint = cellDivider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([
            self.cellDivider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.cellDivider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.cellDivider.topAnchor.constraint(equalTo: self.dateTitleLabel.bottomAnchor, constant: 30),
            self.cellDivider.heightAnchor.constraint(equalToConstant: 1.0),
            bottomConstraint
        ])
        
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onItemClicked(_:))))
    }
    
    @objc
    private func onItemClicked(_ sender: Any) {
        onItemClick?(self.myInsurance)
    }
    
    func setData(data: MyInsurance, isLast: Bool) {
        self.myInsurance = data
        self.titleLabel.text = data.product?.translates?[translatePosition]?.name
        let (title, color) = getTitleForStatus(status: data.status ?? "")
        self.statusContainer.backgroundColor = color
        self.statusLabel.text = title
        self.amountLabel.text = "\(data.totalAmount.toDecimalFormat()) \("sum".localized())"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        let date = formatter.date(from: data.createdAt)
        formatter.dateFormat = "dd.MM.yyyy"
        
        self.dateLabel.text = formatter.string(from: date!)
        if isLast {
            bottomConstraint.constant = -100.0
        } else {
            bottomConstraint.constant = 0.0
        }
    }
    
    private func getTitleForStatus(status: String) -> (String, UIColor) {
        switch status {
        case "new":
            return ("my_new".localized(), UIColor.init(red: 255.0/255.0, green: 197.0/255.0, blue: 47.0/255.0, alpha: 1.0))
        case "canceled":
            return ("my_canceled".localized(), UIColor.init(red: 255.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 1.0))
        case "confirmed":
            return ("my_confirmed".localized(), UIColor.init(red: 100.0/255.0, green: 196.0/255.0, blue: 254.0/255.0, alpha: 1.0))
        case "paid":
            return ("paid".localized(), Colors.primaryGreen)
        case "my_paid":
            return ("completed".localized(), Colors.primaryGreen)
        default:
            return ("", .black)
        }
    }
    
}




