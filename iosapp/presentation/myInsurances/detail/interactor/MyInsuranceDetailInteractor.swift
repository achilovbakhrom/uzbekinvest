//
//  MyInsuranceDetailInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MyInsuranceDetailInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func getClickData(orderId: Int)
    func getPaymeData(orderId: Int)
    func updateMyInsurance(orderId: Int, paymentType: String)
}

class MyInsuranceDetailInteractorImpl: MyInsuranceDetailInteractor {
    var serviceFactory: ServiceFactoryProtocol
    var presenter: BasePresenter?
    
    private lazy var insurancePresenter = self.presenter as? MyInsurancesDetailPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func getClickData(orderId: Int) {
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.click(orderId: orderId)) { [unowned self] result in
                switch result {
                case .success(let response):
                    do {
                        if response.statusCode == 401 {
                            let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                            self.serviceFactory.storage.removeKey(key: "profile")
                            self.serviceFactory.tokenFactory.removeToken()
                            self.insurancePresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                        } else {
                            let decoder = JSONDecoder()
                            let r = try decoder.decode(Click.self, from: response.data)
                            
                            let url = "https://my.click.uz/services/pay/?service_id=\(r.merchantServiceId!)&merchant_id=\(r.merchantId!)&amount=\(r.merchantTransAmount!)&transaction_param=\(r.merchantTransId!)"
                            self.insurancePresenter?.openUrl(urlString: url)
                        }
                    } catch (let error) {
                        self.insurancePresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.insurancePresenter?.showError(msg: error.localizedDescription)
                    break
                }
        }
    }
    
    func getPaymeData(orderId: Int) {
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.payme(orderId: orderId)) { [unowned self] result in
                switch result {
                case .success(let response):
                    do {
                        if response.statusCode == 401 {
                            let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                            self.serviceFactory.storage.removeKey(key: "profile")
                            self.serviceFactory.tokenFactory.removeToken()
                            self.insurancePresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                        } else {
                            let decoder = JSONDecoder()
                            let r = try decoder.decode(Payme.self, from: response.data)
                            let suffix = "m=\(r.merchantId!);ac.order_id=\(r.orderId!);ac.customer_id=\(r.customerId!);a=\(r.amount!);cr=860;l=ru"
                            let base64 = suffix.data(using: .utf8)?.base64EncodedString() ?? ""
                            let url = "https://checkout.paycom.uz/\(base64)"
                            self.insurancePresenter?.openUrl(urlString: url)
                        }
                    } catch (let error) {
                        self.insurancePresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.insurancePresenter?.showError(msg: error.localizedDescription)
                    break
                }
        }
    }
    
    func updateMyInsurance(orderId: Int, paymentType: String) {
        self
        .serviceFactory
        .networkManager
            .user
            .request(.updatePaymentType(orderId: orderId, paymentType: paymentType)) { [unowned self] result in
                switch result {
                case .success:
                    self.insurancePresenter?.updateList()
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    
}
