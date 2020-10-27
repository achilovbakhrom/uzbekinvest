//
//  OrderCheck2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class OrderCheck2VC: BaseViewImpl {
    
    let orderCheck2View: OrderCheck2View = OrderCheck2View.fromNib()
    
    private var orderCheckPresenter: OrderCheckPresenter? {
        get {
            return self.presenter as? OrderCheckPresenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderCheck2View.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(orderCheck2View)
        NSLayoutConstraint.activate([
            self.orderCheck2View.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.orderCheck2View.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.orderCheck2View.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.orderCheck2View.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.orderCheck2View.onBack = { self.orderCheckPresenter?.goBack() }
        self.orderCheckPresenter?.fillData()
        self.orderCheck2View.onToMainPage = {
            self.orderCheckPresenter?.goToMain()
            self.setTabBarHidden(true)
        }
    }
    
    func setData(checkOrder: CheckOrder) {
        checkOrder.product?.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.orderCheck2View.insuranceName.text = t?.name
            }
        })
        
        
        self.orderCheck2View.paymentStatus.text = checkOrder.isActive == 0 ? "not_active".localized() : "active".localized()
        
        self.orderCheck2View.polisAmount.text = checkOrder.startDate
        self.orderCheck2View.leftDays.text = checkOrder.endDate
        self.orderCheck2View.insuranceAmount.text = ""
        
    }
    
}
