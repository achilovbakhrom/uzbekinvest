//
//  OrderCheckPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol OrderCheckPresenter: BasePresenter {
    func setSerial(serial: String)
    func setPolisNumbber(number: Int)
    func openOrderCheck2VC()
    func check()
    func goToMain()
    func goBack()
    func setLoading(isLoading: Bool)
    func openLoginVC(phone: String)
    func setData(data: CheckOrder)
    func fillData()
    func showError(msg: String)
}

class OrderCheckPresenterImpl: OrderCheckPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    var serial: String = ""
    var polisNumber: Int = 0
    var data: CheckOrder!
    
    private lazy var orderCheckRouter = self.router as? OrderCheckRouter
    private lazy var orderCheckInteractor = self.interactor as? OrderCheckInteractor
    
    func setSerial(serial: String) {
        self.serial = serial
        if let vc = self.view as? OrderCheck1VC {
            vc.setEnabled(isEnabled: self.serial != "" && self.polisNumber != 0)
        }
    }
    
    func setPolisNumbber(number: Int) {
        self.polisNumber = number
        if let vc = self.view as? OrderCheck1VC {
            vc.setEnabled(isEnabled: self.serial != "" && self.polisNumber != 0)
        }
    }
    
    func check() {
        self.orderCheckInteractor?.checkOrder(serial: serial, polisNumber: polisNumber)
    }
    
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? OrderCheck1VC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func openOrderCheck2VC() {
        self.orderCheckRouter?.openCheckOrder2VC()
    }
    
    func goToMain() {
        self.orderCheckRouter?.openMainPage()
    }
    
    func goBack() {
        self.orderCheckRouter?.goBack()
    }    
    
    func openLoginVC(phone: String) {
        self.orderCheckRouter?.openLoginVC(phone: phone)
    }
    
    func setData(data: CheckOrder) {
        self.data = data
    }
    
    func fillData() {
        if let vc = self.view as? OrderCheck2VC {
            vc.setData(checkOrder: self.data)
        }
    }
    func showError(msg: String) {
        if let vc = self.view as? OrderCheck1VC {
            vc.showErrorMessage(msg: msg)
        }
    }
}
