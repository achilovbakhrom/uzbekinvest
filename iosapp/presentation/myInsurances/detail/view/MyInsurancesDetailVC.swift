//
//  MyInsurancesDetailVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyInsurancesDetailVC: BaseViewImpl {
    
    var myInsurance: MyInsurance!
    var properties: [String: String] = [:]
    
    private lazy var paid: MyInsurancesPaidView = MyInsurancesPaidView.fromNib()
    private lazy var unpaid: MyInsurancesUnpaidView = MyInsurancesUnpaidView.fromNib()
    private lazy var new: MyInsuranceNewView = MyInsuranceNewView.fromNib()
    
    private lazy var myInsurancePresenter = self.presenter as? MyInsurancesDetailPresenter
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myInsurancePresenter?.setMyInsuance(myInsurance: self.myInsurance)
        if myInsurance.status == "new" {
            self.setNewMode()
        } else if myInsurance.status == "confirmed" {
            self.setUnpaidMode()
        } else {
            self.setPaidMode()
        }
        paid.onBackClicked = { self.myInsurancePresenter?.goBack() }
        unpaid.onBackButton = { self.myInsurancePresenter?.goBack() }
        new.onBack = { self.myInsurancePresenter?.goBack() }
        new.onPaymentTypeSelected = { _ in
            // 0 - "online"
            // 1 - "cash"
            // 2 - "terminal"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabBarHidden(true)
        self.view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    func setNewMode() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.new.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        scrollView.addSubview(new)
        NSLayoutConstraint.activate([
            self.new.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.new.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.new.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.new.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.new.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        self.new.insuranceName.text = myInsurance.product?.translates?[translatePosition]?.name
        self.new.insuranceAmount.text = "\(myInsurance.insuranceAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        self.new.startDateLabel.text = myInsurance.startDate
        self.new.endDateLabel.text = myInsurance.endDate
        self.new.setProperties(property: self.properties)
    }
    
    func setPaidMode() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.paid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        scrollView.addSubview(paid)
        NSLayoutConstraint.activate([
            self.paid.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.paid.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.paid.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.paid.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.paid.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        self.paid.insuranceName.text = myInsurance.product?.translates?[0]?.name
        self.paid.insuranceAmount.text = "\(myInsurance.insuranceAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        self.paid.setProperties(property: self.properties)
    }
    
    func setUnpaidMode() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.unpaid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        scrollView.addSubview(unpaid)
        
        NSLayoutConstraint.activate([
            self.unpaid.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.unpaid.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.unpaid.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.unpaid.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.unpaid.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        self.unpaid.insuranceAmount.text = myInsurance.product?.translates?[0]?.name
        self.unpaid.amount.text = "\(myInsurance.insuranceAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        self.unpaid.transactionNumber.text = myInsurance.startDate
        
        self.unpaid.subject.text = myInsurance.endDate
        self.unpaid.setProperties(property: self.properties)
        self.unpaid.onPay = {
            
        }
    }
    
}

