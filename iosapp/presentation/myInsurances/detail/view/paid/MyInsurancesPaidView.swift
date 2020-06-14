//
//  MyInsurancePaidView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MyInsurancesPaidView: UIView {
    
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var leftDays: UILabel!
    @IBOutlet weak var paymentType: UILabel!
    @IBOutlet weak var transactionNumber: UILabel!
    
    @IBOutlet weak var incidentsButton: Button!
    @IBOutlet weak var insuranceName: UILabel!
    @IBOutlet weak var propertiesView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    
    
    var onBackClicked: (() -> Void)? = nil
    var onIncidentsClicked: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackButtonClicked)))
        incidentsButton.addTarget(self, action: #selector(onIncidentsButtonClicekd), for: .touchUpInside)
        statusContainer.layer.cornerRadius = statusContainer.bounds.height/2
        incidentsButton.makeRedColor()
    }
    
    @objc
    private func onBackButtonClicked() {
        onBackClicked?()
    }
    
    @objc
    private func onIncidentsButtonClicekd() {
        onIncidentsClicked?()
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
    
}
