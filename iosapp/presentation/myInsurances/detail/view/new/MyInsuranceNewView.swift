//
//  MyInsuranceNewView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyInsuranceNewView: UIView, UICollectionViewDataSource, UISearchControllerDelegate, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var insuranceName: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var paymentTypeCV: UICollectionView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var propertiesView: UIView!
    @IBOutlet weak var statusName: UILabel!
    
    var onPaymentTypeSelected: ((Int) -> Void)? = nil
    var onBack: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        (paymentTypeCV.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        paymentTypeCV.backgroundColor = .white
        paymentTypeCV.delegate = self
        paymentTypeCV.dataSource = self
        paymentTypeCV.register(PaymentTypeCell.self, forCellWithReuseIdentifier: String(describing: PaymentTypeCell.self))
        self.statusContainer.layer.cornerRadius =  self.statusContainer.bounds.height/2.0
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonAction(_:))))
        self.statusContainer.backgroundColor = UIColor.init(red: 255.0/255.0, green: 197.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        
    }
    
    @objc
    private func backButtonAction(_ gesture: UITapGestureRecognizer) {
        self.onBack?()
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
    
    private lazy var paymentTypesList: [PaymentTypeCellModel] = {
        return [
            PaymentTypeCellModel(icon: "online-pay", title: "Онлайн \nоплата", selected: false, isFirst: true),
            PaymentTypeCellModel(icon: "cash-pay", title: "Наличные", selected: false, isFirst: false),
            PaymentTypeCellModel(icon: "card-pay", title: "Карта", selected: false, isFirst: false),
        ]
    }()
    
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
    
    var selected: Int = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PaymentTypeCell.self), for: indexPath) as! PaymentTypeCell
        
        cell.onClick = {
            self.selected = indexPath.row
            UIView.transition(with: self.paymentTypeCV, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.paymentTypeCV.reloadSections(IndexSet(integer: 0))
            }, completion: { _ in
                self.onPaymentTypeSelected?(indexPath.row)
            })
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        cell.hasTopMargin = true
        var data = paymentTypesList[indexPath.row]
        data.isFirst = indexPath.row == 0
        data.selected = indexPath.row == selected
        cell.setData(model: data)
        return cell
    }
    
}
