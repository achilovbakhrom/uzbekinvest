//
//  AccidentInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol AccidentInteractor {
    
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateAccident(myHealth: MyHealth)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
    
}

class AccidentInteractorImpl: BaseInsuranceInteractor, AccidentInteractor {
    
    private lazy var accidentPresenter = self.presenter as? AccidentPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateAccident(myHealth: MyHealth) {
        self.accidentPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory?.networkManager
            .orders
            .request(.myHealth(health: myHealth), completion: {
                switch $0 {
                case .success(let response):
                    self.accidentPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                        self.accidentPresenter?.setTotalAmount(amount: self.serviceFactory?.formatter.decimalFormat(number: result.data?.totalAmount ?? 0) ?? "0")
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.accidentPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.accidentPresenter?.openAccidentFinalVC()
            }
        }
    }
    
}
