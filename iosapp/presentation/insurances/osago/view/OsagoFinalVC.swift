//
//  OsagoFinalVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OsagoFinalVC: BaseInsuranceConfirmVC {
    
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
//    private lazy var addressView: PropertyRowView = {
//        let view = PropertyRowView()
//        view.mode = .info
//        view.titleLabel.text = "Адрес доставки"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentLabel.text = "Uzbekistan , Tashkent , Mirzo Ulugbek district, Qorasu 2 , 13/24"
//        view.isStatusChecked = true
//        return view
//    }()
//
//    private lazy var startDateView: PropertyRowView = {
//        let view = PropertyRowView()
//        view.mode = .info
//        view.titleLabel.text = "Дата начала страхования"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentLabel.text = "01.01.2020"
//        view.isStatusChecked = true
//        return view
//    }()
//
//    private lazy var driverLicenseView: PropertyRowView = {
//        let view = PropertyRowView()
//        view.mode = .doc
//        view.titleLabel.text = "Водительские права"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentLabel.text = "DCIM00321.jpg"
//        view.descriptionLabel.text = "Orci varius natoque penatibus "
//        view.isStatusChecked = true
//        return view
//    }()
//
//    private lazy var techPassportView: PropertyRowView = {
//        let view = PropertyRowView()
//        view.mode = .upload
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.titleLabel.text = "Водительские права"
//        view.isStatusChecked = false
//        return view
//    }()
//
//    private lazy var addressTitle: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.textColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.init(name: "Roboto-Regular", size: 14)
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Страхование \nпутешествующих"
        paymentLabel.text = "360 000 sum"
//        self.setupUI()
    }
    
    
    override func onPaymentTypeSelected(seq: Int) {
        
    }
    
//    private func setupUI() {
//        self.propertiesView.addSubview(addressView)
//        NSLayoutConstraint.activate([
//            self.addressView.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            self.addressView.topAnchor.constraint(equalTo: self.propertiesView.topAnchor),
//            self.addressView.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
//        ])
//
//        let div1 = createDivider()
//        self.propertiesView.addSubview(div1)
//        NSLayoutConstraint.activate([
//            div1.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            div1.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
//            div1.topAnchor.constraint(equalTo: self.addressView.bottomAnchor),
//            div1.heightAnchor.constraint(equalToConstant: 1.0)
//        ])
//
//        self.propertiesView.addSubview(startDateView)
//        NSLayoutConstraint.activate([
//            self.startDateView.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            self.startDateView.topAnchor.constraint(equalTo: div1.bottomAnchor),
//            self.startDateView.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
//        ])
//
//        let div2 = createDivider()
//        self.propertiesView.addSubview(div2)
//        NSLayoutConstraint.activate([
//            div2.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            div2.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
//            div2.topAnchor.constraint(equalTo: self.startDateView.bottomAnchor),
//            div2.heightAnchor.constraint(equalToConstant: 1.0)
//        ])
//
//        self.propertiesView.addSubview(driverLicenseView)
//        NSLayoutConstraint.activate([
//            self.driverLicenseView.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            self.driverLicenseView.topAnchor.constraint(equalTo: div2.bottomAnchor),
//            self.driverLicenseView.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
//        ])
//        let div3 = createDivider()
//        self.propertiesView.addSubview(div3)
//        NSLayoutConstraint.activate([
//            div3.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            div3.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
//            div3.topAnchor.constraint(equalTo: self.driverLicenseView.bottomAnchor),
//            div3.heightAnchor.constraint(equalToConstant: 1.0)
//        ])
//
//        self.propertiesView.addSubview(techPassportView)
//        NSLayoutConstraint.activate([
//            self.techPassportView.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            self.techPassportView.topAnchor.constraint(equalTo: div3.bottomAnchor),
//            self.techPassportView.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
//            self.techPassportView.bottomAnchor.constraint(equalTo: self.propertiesView.bottomAnchor, constant: 15)
//        ])
//
//        let div4 = createDivider()
//        self.propertiesView.addSubview(div4)
//        NSLayoutConstraint.activate([
//            div4.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//            div4.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
//            div4.topAnchor.constraint(equalTo: self.techPassportView.bottomAnchor),
//            div4.heightAnchor.constraint(equalToConstant: 1.0)
//        ])
//
//    }
    
    func setLoading(isLoading: Bool) {
        
    }
    func setEnabled(isEnabled: Bool) {
        
    }
}
