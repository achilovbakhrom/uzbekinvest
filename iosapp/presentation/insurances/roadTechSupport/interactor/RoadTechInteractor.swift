//
//  RoadTechInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol RoadTechInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateTechnicalSupport(technicalSupport: TechnicalSupport)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
    
}

class RoadTechInteractorImpl: BaseInsuranceInteractor, RoadTechInteractor {
    
    
    private lazy var roadTechPresenter = self.presenter as? RoadTechPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateTechnicalSupport(technicalSupport: TechnicalSupport) {
        self.roadTechPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.technicalSupportCalculate(technicalSupport: technicalSupport)) {
                switch $0 {
                case .success(let response):
                    self.roadTechPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                        self.roadTechPresenter?.setTotalAmount(totalAmount: result.data?.totalAmount.toDecimalFormat() ?? "0")
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.roadTechPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.roadTechPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.roadTechPresenter?.openTechRoadFinalVC()
            }
        }
    }
    
}
