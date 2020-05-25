//
//  HealthInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol HealthInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculate(health: MedicalInsurance)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
    
}

struct HealthInsuranceResult: Codable {

    var totalAmount: Double
    var premiumAmount: Double
    enum CodingKeys: String, CodingKey {
        case totalAmount = "total_amount"
        case premiumAmount = "premium_amount"
    }
    
}

class HealthInteractorImpl: BaseInsuranceInteractor, HealthInteractor {
    private lazy var healthPresenter = self.presenter as? HealthPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculate(health: MedicalInsurance) {
        self
            .serviceFactory?.networkManager.orders.request(.medicalCalculate(medical: health), completion: {
                self.healthPresenter?.setLoading(isLoading: true)
                switch $0 {
                case .success(let response):
                    self.healthPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Response<HealthInsuranceResult>.self, from: response.data)
                        self.healthPresenter?.setTotalAmount(totalAmount: "\(result.data?.totalAmount ?? 0)")
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.healthPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
        
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.healthPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.healthPresenter?.openHealthFinalVC()
            }
        }
    }
    
}
