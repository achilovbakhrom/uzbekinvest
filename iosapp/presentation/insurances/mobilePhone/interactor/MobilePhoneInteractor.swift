//
//  MobilePhoneInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MobilePhoneInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculatePhone(mobilePhone: MobilePhone)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
}


class MobilePhoneInteractorImpl: BaseInsuranceInteractor, MobilePhoneInteractor {
    
    private lazy var mobilePhonePresenter = self.presenter as? MobilePhonePresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func calculatePhone(mobilePhone: MobilePhone) {
        self.mobilePhonePresenter?.setLoading(isLoading: true)
        self.serviceFactory.networkManager.orders.request(.phoneCalculate(mobilePhone: mobilePhone)) {
            switch $0 {
            case .success(let response):
                self.mobilePhonePresenter?.setLoading(isLoading: false)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                    self.mobilePhonePresenter?.setTotalAmount(totalAmount: result.data?.totalAmount.toDecimalFormat() ?? "0")
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.mobilePhonePresenter?.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.mobilePhonePresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.mobilePhonePresenter?.openMobilePhoneFinalVC()
            }
        }
    }
    
}
