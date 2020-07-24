//
//  GasInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol GasInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateGasHome(gasHome: GasHome)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
}


class GasInteractorImpl: BaseInsuranceInteractor, GasInteractor {
    
    private lazy var gasPresenter = self.presenter as? GasPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    
    func calculateGasHome(gasHome: GasHome) {
        self.gasPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory.networkManager
            .orders.request(.gasHomeCalculate(gasHome: gasHome)) {
                switch $0 {
                case .success(let response):
                    self.gasPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                        self.gasPresenter?.setTotalAmount(totalAmount: result.data?.totalAmount.toDecimalFormat() ?? "")
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.gasPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
        
    }
    
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.gasPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.gasPresenter?.openGasFinalVC()
            }
        }
    }
    
}
