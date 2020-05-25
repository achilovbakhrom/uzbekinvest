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
        self.view.addSubview(orderCheck2View)
        NSLayoutConstraint.activate([
            self.orderCheck2View.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.orderCheck2View.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.orderCheck2View.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.orderCheck2View.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.orderCheck2View.onBack = { self.orderCheckPresenter?.goBack() }
        self.orderCheckPresenter?.fillData()
        self.orderCheck2View.onToMainPage = { self.orderCheckPresenter?.goToMain() }
    }
    
    func setData(checkOrder: CheckOrder) {
        self.orderCheck2View.insuranceName.text = checkOrder.product?.translates?[0]?.name
        self.orderCheck2View.paymentStatus.text = "New"
        self.orderCheck2View.polisAmount.text = "1 000 000 сум"
        self.orderCheck2View.leftDays.text = "100 дней"
        self.orderCheck2View.insuranceAmount.text = "1 000 000 сум"
    }
    
}
