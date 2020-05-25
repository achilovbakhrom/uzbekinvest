//
//  LuggageInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol LuggageInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateLuggage(luggage: Luggage)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
}

class LuggageInteractorImpl: BaseInsuranceInteractor, LuggageInteractor {
    
    private lazy var luggagePresenter = self.presenter as? LuggagePresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateLuggage(luggage: Luggage) {
        self.luggagePresenter?.setLoading(isLoading: true)
        self
        .serviceFactory
        .networkManager
        .orders
            .request(.luggageCalculate(luggage: luggage)) { [unowned self] result in
                self.luggagePresenter?.setLoading(isLoading: false)
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                        self.luggagePresenter?.setTotalAmount(totalAmount: r.data?.totalAmount ?? 0)
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.luggagePresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.luggagePresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.luggagePresenter?.openLuggageFinalVC()
            }
        }
    }
}
