//
//  SportInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol SportInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateSport(sport: Sport)
    func fetchSportList()
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
    
}

class SportInteractorImpl: BaseInsuranceInteractor, SportInteractor {

    private lazy var sportPresenter = self.presenter as? SportsPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateSport(sport: Sport) {
        self.sportPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.sportCalculate(sport: sport)) {
                switch $0 {
                case .success(let response):
                    self.sportPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                        self.sportPresenter?.setTotalAmount(totalAmount: result.data?.totalAmount.toDecimalFormat() ?? "0")
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.sportPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func fetchSportList() {
        self.sportPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.sports) {
                switch($0) {
                case .success(let response):
                    self.sportPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(ArrayResponse<SportModel>.self, from: response.data)
                        self.sportPresenter?.setSports(ids: result.data?.map {$0.id} ?? [], array: result.data?.map {$0.name ?? ""} ?? [])
                    } catch(let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.sportPresenter?.setLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.sportPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.sportPresenter?.openSportFinalVC()
            }
        }
    }
    
}
