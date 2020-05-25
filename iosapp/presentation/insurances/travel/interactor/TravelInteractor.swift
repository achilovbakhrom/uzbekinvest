//
//  TravelInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol TravelInteractor {
    func fetchCountryList()
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateTravel(travel: Travel)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
    func fetchSports()
    func fetchWork()
}

class TravelInteractorImpl: BaseInsuranceInteractor, TravelInteractor {
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    
    func fetchCountryList() {
        self.travelPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.country) { result in
                self.travelPresenter?.setLoading(isLoading: false)
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<Country>.self, from: response.data)
                        self.travelPresenter?.setCountryList(list: r.data ?? [])
                    } catch (let error) {
                        self.travelPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.travelPresenter?.setLoading(isLoading: false)
                    self.travelPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func calculateTravel(travel: Travel) {
        self.travelPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.travelCalculate(travel: travel)) { result in
                self.travelPresenter?.setLoading(isLoading: false)
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<TravelInusranceResult>.self, from: response.data)
                        self.travelPresenter?.setTotalAmount(amount: r.data?.totalAmount ?? 0.0)
                        
                    } catch (let error) {
                        self.travelPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.travelPresenter?.setLoading(isLoading: false)
                    self.travelPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.travelPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.travelPresenter?.openTravelFinalVC()
            }
        }
    }
    
    func fetchSports() {
        self.travelPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.sports) { result in
                self.travelPresenter?.setLoading(isLoading: false)
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<SportModel>.self, from: response.data)
                        self.travelPresenter?.setSport(sports: r.data ?? [])
                    } catch (let error) {
                        self.travelPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.travelPresenter?.setLoading(isLoading: false)
                    self.travelPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func fetchWork() {
        self.travelPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.work) { result in
                self.travelPresenter?.setLoading(isLoading: false)
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<Work>.self, from: response.data)
                        self.travelPresenter?.setWork(work: r.data ?? [])
                    } catch (let error) {
                        self.travelPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.travelPresenter?.setLoading(isLoading: false)
                    self.travelPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
}

struct TravelInusranceResult: Codable {
    var totalAmount: Double
    var premiumAmount: Double
    var referer: Referer?
    enum CodingKeys: String, CodingKey {
        case totalAmount = "total_amount"
        case premiumAmount = "premium_amount"
        case referer
    }
}
