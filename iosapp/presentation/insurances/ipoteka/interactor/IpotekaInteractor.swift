//
//  IpotekaInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol IpotekaInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateIpoteka(ipoteka: PledgedProperty)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
    func prepareToOpenFinalVC(id: Int)
}

class IpotekaInteractorImpl: BaseInsuranceInteractor, IpotekaInteractor {
    
    private lazy var ipotekaPresenter = self.presenter as? IpotekaPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateIpoteka(ipoteka: PledgedProperty) {
        self.ipotekaPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .orders.request(.ipotekaCalculate(pledgedProperty: ipoteka)) {
                switch $0 {
                case .success(let resposne):
                    self.ipotekaPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: resposne.data)
                        self.ipotekaPresenter?.setTotalAmount(amount: self.serviceFactory.formatter.decimalFormat(number: result.data?.totalAmount ?? 0))
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.ipotekaPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.ipotekaPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.ipotekaPresenter?.openIpotekaFinalVC()
            }
        }
    }
}
