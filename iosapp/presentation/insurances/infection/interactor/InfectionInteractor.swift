//
//  InfectionInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol InfectionInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateInfection(infection: Infection)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
    
}

class InfectionInteractorImpl: BaseInsuranceInteractor, InfectionInteractor {
    private lazy var infectionPresenter = self.presenter as? InfectionPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateInfection(infection: Infection) {
        self.infectionPresenter?.setLoading(isLoading: true)
        self.serviceFactory.networkManager.orders.request(.infectionCalculate(infection: infection)) { [unowned self] result in
            switch result {
            case .success(let response):
                self.infectionPresenter?.setLoading(isLoading: false)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                    self.infectionPresenter?.setTotalAmount(totalAmount: "\(result.data?.totalAmount ?? 0)")
                } catch (let error) {
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.infectionPresenter?.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { [unowned self] isLoading in
            self.infectionPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.infectionPresenter?.openInfectionFinalVC()
            }
        }
    }
}
