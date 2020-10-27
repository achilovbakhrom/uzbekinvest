//
//  MandatoryInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MandatoryInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateMandatory(pledgedTransport: PledgedTransport)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
}


class MandatoryInteractorImpl: BaseInsuranceInteractor, MandatoryInteractor {
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func calculateMandatory(pledgedTransport: PledgedTransport) {
        self.mandatoryPresenter?.setLoading(isLoading: true)
        self.serviceFactory.networkManager.orders.request(.pledgedTransportCalculate(pledgedTransport: pledgedTransport)) { [unowned self] result in
            self.mandatoryPresenter?.setLoading(isLoading: false)
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let r = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                    self.mandatoryPresenter?.setTotalAmount(formatAmount: self.serviceFactory.formatter.decimalFormat(number: r.data?.totalAmount ?? 0), totalAmount: r.data?.totalAmount ?? 0, premiumAmount: r.data?.premiumAmount ?? 0)
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.mandatoryPresenter?.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { [unowned self] isLoading in
            self.mandatoryPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.mandatoryPresenter?.openMandatoryFinalVC()                
            }
        }
    }
    
}
