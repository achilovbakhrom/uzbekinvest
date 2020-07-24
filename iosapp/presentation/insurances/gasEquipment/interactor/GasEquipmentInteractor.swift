//
//  GasHomeInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
protocol GasEquipmentInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateGasEquipment(gasAuto: GasAuto)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
}

class GasEquipmentInteractorImpl: BaseInsuranceInteractor, GasEquipmentInteractor {
    
    private lazy var gasEquipmentPresenter = self.presenter as? GasEquipmentPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    
    func calculateGasEquipment(gasAuto: GasAuto) {
        self.gasEquipmentPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.gasAutoCalculate(gasHome: gasAuto)) { [unowned self] result in
                
                switch result {
                case .success(let response):
                    self.gasEquipmentPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let r = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                        self.gasEquipmentPresenter?.setTotalAmount(amount: r.data?.totalAmount ?? 0)
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.gasEquipmentPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.gasEquipmentPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.gasEquipmentPresenter?.openGasEquipmentFinalVC()
            }
        }
    }
    
}
