//
//  OrderCheck1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OrderCheck1VC: BaseWithLeftCirclesVC {
    
    private lazy var orderCheck1View: OrderCheck1View = OrderCheck1View.fromNib()
    
    private var orderCheckPresenter: OrderCheckPresenter? {
        get {
            return self.presenter as? OrderCheckPresenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarHidden(true)
        self.view.backgroundColor = .white
        self.view.addSubview(orderCheck1View)
        orderCheck1View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.orderCheck1View.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.orderCheck1View.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 35),
            self.orderCheck1View.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.orderCheck1View.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.orderCheck1View.checkButton.isEnabled = false
        
        self.orderCheck1View.orderList.onChange = {
            self.orderCheckPresenter?.setSerial(serial: $0)
        }
        self.orderCheck1View.polisNumber.onChange = {
            self.orderCheckPresenter?.setPolisNumbber(number: Int($0) ?? 0)
        }
        self.backButtonClicked = {
            self.orderCheckPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.orderCheck1View.onCheckClicked = { self.orderCheckPresenter?.check() }
        self.setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    func setLoading(isLoading: Bool) {
        self.orderCheck1View.checkButton.isLoading = isLoading
    }
    
    func setEnabled(isEnabled: Bool) {
        self.orderCheck1View.checkButton.isEnabled = isEnabled
    }
    
}
