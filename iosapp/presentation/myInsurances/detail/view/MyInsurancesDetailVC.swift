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
            switch myInsurance.paymentMethod {
            case "online":
                self.new.selected = 0
                break
            case "cash":
                self.new.selected = 1
                break
            case "terminal":
                self.new.selected = 2
                break
            default:
                break
            }
            self.setNewMode()
        } else if myInsurance.status == "confirmed" {
            self.setUnpaidMode()
        } else {
            self.setPaidMode()
        }
        paid.onBackClicked = {
            self.myInsurancePresenter?.goBack()
            self.setTabBarHidden(false)
        }
        unpaid.onBackButton = {
            self.myInsurancePresenter?.goBack()
            self.setTabBarHidden(false)
        }
        new.onBack = {
            self.myInsurancePresenter?.goBack()
            self.setTabBarHidden(false)
        }
        new.onPaymentTypeSelected = { type in
            switch type {
            case 0:
                self.myInsurancePresenter?.setPaymentType(paymentType: "online")
                break
            case 1:
                self.myInsurancePresenter?.setPaymentType(paymentType: "cash")
                break
            case 2:
                self.myInsurancePresenter?.setPaymentType(paymentType: "terminal")
                break
            default:
                break
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

    }
    
    // my selector that was defined above
    @objc func willEnterForeground() {
        self.setTabBarHidden(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabBarHidden(true)
        self.view.backgroundColor = .white
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
        
        myInsurance.product?.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.new.insuranceName.text = t?.name
            }
        })
        
//        self.new.insuranceName.text = myInsurance.product?.translates?[translatePosition]?.name
        self.new.insuranceAmount.text = "\(myInsurance.totalAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        self.new.startDateLabel.text = myInsurance.startDate
        self.new.endDateLabel.text = myInsurance.endDate
        self.new.setProperties(property: self.properties)
        
        switch self.myInsurance.status ?? "" {
        case "new":
            self.new.statusName.text = "my_new".localized()
            break
        case "canceled":
            self.new.statusName.text = "my_canceled".localized()
            break
        case "confirmed":
            self.new.statusName.text = "my_confirmed".localized()
            break
        case "paid":
            self.new.statusName.text = "paid".localized()
            break
        case "my_paid":
            self.new.statusName.text = "completed".localized()
            break
        case "completed":
            self.new.statusName.text = "completed".localized()
            break
        default:
            self.new.statusName.text = ""
            break
        }
        
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
        self.paid.statusLabel.text = myInsurance.status == "canceled" ? "my_canceled".localized() : "paid".localized()
        self.paid.statusContainer.backgroundColor = myInsurance.status == "canceled" ? UIColor.init(red: 255.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 1.0) : Colors.primaryGreen
        self.paid.insuranceName.text = myInsurance.product?.translates?[0]?.name
        self.paid.insuranceAmount.text = "\((myInsurance.totalAmount ?? 0).toDecimalFormat()) \("sum".localized())"
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: myInsurance.endDate ?? "") ?? Date()
        let now = Date()
        var diff = Int((date.timeIntervalSince1970 - now.timeIntervalSince1970)/86400)
        if diff < 0 { diff = 0 }
        self.paid.leftDays.text = "\(diff) \("days".localized())"
        self.paid.startDateLabel.text = self.myInsurance.startDate
        self.paid.endDateLabel.text = self.myInsurance.endDate
        self.paid.setProperties(property: self.properties)
        self.paid.incidentsButton.isHidden = myInsurance.status == "canceled"
        
        switch self.myInsurance.status ?? "" {
        case "new":
            self.paid.statusLabel.text = "my_new".localized()
            break
        case "canceled":
            self.paid.statusLabel.text = "my_canceled".localized()
            break
        case "confirmed":
            self.paid.statusLabel.text = "my_confirmed".localized()
            break
        case "paid":
            self.paid.statusLabel.text = "paid".localized()
            break
        case "my_paid":
            self.paid.statusLabel.text = "completed".localized()
            break
        case "completed":
            self.paid.statusLabel.text = "completed".localized()
            break
        default:
            self.paid.statusLabel.text = ""
            break
        }
    }
    var pt = 0
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
        self.unpaid.amount.text = "\(myInsurance.totalAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        self.unpaid.transactionNumber.text = myInsurance.startDate
        
        self.unpaid.subject.text = myInsurance.endDate
        self.unpaid.setProperties(property: self.properties)
        self.unpaid.paymentTypeChange = { pt in
            self.myInsurancePresenter?.setPaymentMode(mode: pt)
        }
        
        self.unpaid.onPay = {
            self.myInsurancePresenter?.pay()
        }
        
        switch self.myInsurance.status ?? "" {
        case "new":
            self.unpaid.statusName.text = "my_new".localized()
            break
        case "canceled":
            self.unpaid.statusName.text = "my_canceled".localized()
            break
        case "confirmed":
            self.unpaid.statusName.text = "my_confirmed".localized()
            break
        case "paid":
            self.unpaid.statusName.text = "paid".localized()
            break
        case "my_paid":
            self.unpaid.statusName.text = "completed".localized()
            break
        case "completed":
            self.unpaid.statusName.text = "completed".localized()
            break
        default:
            self.unpaid.statusName.text = ""
            break
        }
    }
    
}

