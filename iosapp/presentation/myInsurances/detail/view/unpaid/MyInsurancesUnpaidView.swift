//
//  MyInsurancesUnpaidView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyInsurancesUnpaidView: UIView {
    
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var insuranceAmount: UILabel! // name
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var transactionNumber: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var propertiesView: UIView!
    @IBOutlet weak var paymeClick: UIView!
    @IBOutlet weak var clickClicked: UIView!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var statusName: UILabel!
    
    
    
    var onBackButton: (() -> Void)? = nil
    var paymentTypeChange: ((Int) -> Void)? = nil
    var onPay: (() -> Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusContainer.layer.cornerRadius = statusContainer.bounds.height/2
        self.statusContainer.layer.masksToBounds = true
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonClicked(_:))))
        
        self.paymeClick.isUserInteractionEnabled = true
        self.paymeClick.layer.cornerRadius = 10.0
        self.paymeClick.layer.masksToBounds = true
        self.paymeClick.layer.borderColor = Colors.primaryGreen.cgColor
        self.paymeClick.layer.borderWidth = 1.5
        self.paymeClick.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPaymeClicked(gesture:))))
        
        self.clickClicked.isUserInteractionEnabled = true
        self.clickClicked.layer.cornerRadius = 10.0
        self.clickClicked.layer.masksToBounds = true
        self.clickClicked.layer.borderColor = Colors.primaryGreen.cgColor
        self.clickClicked.layer.borderWidth = 0.0
        self.clickClicked.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickClicked(gesture:))))
        
    }
    
    @objc
    private func onPaymeClicked(gesture: UITapGestureRecognizer) {
        UIView.transition(with: self.paymeClick, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.paymeClick.layer.borderWidth = 1.5
            self.clickClicked.layer.borderWidth = 0.0
        }, completion: nil)
        
        self.paymentTypeChange?(0)
    }
    
    @objc
    private func onClickClicked(gesture: UITapGestureRecognizer) {
        UIView.transition(with: self.clickClicked, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.paymeClick.layer.borderWidth = 0.0
            self.clickClicked.layer.borderWidth = 1.5
        }, completion: nil)
        
        self.paymentTypeChange?(1)
    }
    
    @objc
    private func backButtonClicked(_ sender: Any) {
        self.onBackButton?()
    }
    
    var lastItem: UIView!
    
    private func createRow(title: String, value: String) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let titleLabel = UILabel.init(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 23),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
        ])
        
        let valueLabel = UILabel.init(frame: .zero)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.font = UIFont.init(name: "Roboto-Bold", size: 17.0)
        view.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            valueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -23)
        ])
        return view
    }
    
    func setProperties(property: [String: String]) {
        var index = 0
        for key in property.keys {
            let row = createRow(title: key, value: property[key] ?? "")
            self.propertiesView.addSubview(row)
            
            if lastItem == nil {
                NSLayoutConstraint.activate([
                    row.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                    row.topAnchor.constraint(equalTo: self.propertiesView.topAnchor),
                    row.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    row.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                    row.topAnchor.constraint(equalTo: self.lastItem.bottomAnchor),
                    row.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                ])
            }
            if index == property.count - 1 {
                row.bottomAnchor.constraint(equalTo: self.propertiesView.bottomAnchor).isActive = true
            }
            lastItem = row
            index += 1
        }
        
    }
    
    
    @IBAction func payButtonAction(_ sender: Any) {
        self.onPay?()
    }
    
    
}
