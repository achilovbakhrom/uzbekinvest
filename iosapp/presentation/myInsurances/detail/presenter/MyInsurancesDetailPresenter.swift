//
//  MyInsurancesDetailPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MyInsurancesDetailPresenter: BasePresenter {
    
    func pay()
    func setPaymentType(paymentType: String)
    func goBack()
    
    func setMyInsuance(myInsurance: MyInsurance)
    func setPaymentMode(mode: Int)
    func openLoginVC(phone: String)
    func openUrl(urlString: String)
    func showError(msg: String)
    func updateList()
    func openIncidents()
}

class MyInsurancesDetailPresenterImpl: MyInsurancesDetailPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var myInsuranceDetailView = self.view as? MyInsurancesDetailVC
    private lazy var myInsuranceDetailRouter = self.router as? MyInsuranceDetailRouter
    private lazy var myInsuranceDetailInteractor = self.interactor as? MyInsuranceDetailInteractor
    
    private var myInsurance: MyInsurance!
    private var paymentMode = 0 // payme
    
    func setMyInsuance(myInsurance: MyInsurance) {
        self.myInsurance = myInsurance
    }
    
    func setPaymentMode(mode: Int) {
        self.paymentMode = mode
    }
    
    func pay() {
        if paymentMode == 0 { // payme
            self.myInsuranceDetailInteractor?.getPaymeData(orderId: myInsurance.id)
        } else { // click
            self.myInsuranceDetailInteractor?.getClickData(orderId: myInsurance.id)
        }
    }
    
    func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    func setPaymentType(paymentType: String) {
        self.myInsurance.paymentMethod = paymentType
        self.myInsuranceDetailInteractor?.updateMyInsurance(orderId: self.myInsurance.id, paymentType: paymentType)
    }
    
    
    func goBack() {
        self.myInsuranceDetailRouter?.goBack()
    }
    
    func openLoginVC(phone: String) {
        self.myInsuranceDetailRouter?.openLoginVC(phone: phone)
    }
    
    func showError(msg: String) {
        self.myInsuranceDetailView?.showErrorMessage(msg: msg)
    }
    
    func updateList() {
        let nc = self.view?.navigationController
        if let n = nc?.viewControllers[0] as? MyInsuranceVC {
            n.reloadList()
        }
    }
    func openIncidents() {
        self.myInsuranceDetailRouter?.openIncidents()
    }
}


