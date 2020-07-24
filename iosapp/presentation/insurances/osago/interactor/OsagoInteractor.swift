//
//  OsagoInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation


protocol OsagoInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchRegionList()
    func fetchTransportList()
    func calculateOsago(osago: Osago)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
}

class OsagoInteractorImpl: BaseInsuranceInteractor, OsagoInteractor {
    
    
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.osagoPresenter.setLoading(isLoading: isLoading)
            if !isLoading {
                self.osagoPresenter.openOsagoFinal()
            }
        }
    }
    
    func calculateOsago(osago: Osago) {
        
        self.serviceFactory.networkManager.orders.request(.osagoCalculate(osago: osago)) { result in
            self.osagoPresenter.setLoading(isLoading: true)
            switch result {
            case .success(let response):
                self.osagoPresenter.setLoading(isLoading: false)
                do {
                    let decoder = JSONDecoder()
                    let r = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                    self.osagoPresenter.setAmount(amount: r.data?.totalAmount ?? 0)
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.osagoPresenter.setLoading(isLoading: true)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchRegionList() {
        self.osagoPresenter.setLoading(isLoading: true)
        self.serviceFactory.networkManager.regions.request(.getAllRegions) { result in
            switch result {
            case .success(let result):
                self.osagoPresenter.setLoading(isLoading: false)
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ArrayResponse<Region>.self, from: result.data)
                    self.osagoPresenter.setRegions(regionList: response.data ?? [])
                } catch let error {
                    print(error.localizedDescription)
                    print("error")
                }
                break
            case .failure(let error):
                self.osagoPresenter.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchTransportList() {
        self.osagoPresenter.setLoading(isLoading: true)
        self.serviceFactory.networkManager.transport.request(.getAllTransports) { result in
            switch result {
            case .success(let result):
                self.osagoPresenter.setLoading(isLoading: false)
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ArrayResponse<Transport>.self, from: result.data)
                    self.osagoPresenter.setTransportList(list: response.data ?? [])
                } catch let error {
                    print(error.localizedDescription)
                    print("error")
                }
                break
            case .failure(let error):
                self.osagoPresenter.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
}
