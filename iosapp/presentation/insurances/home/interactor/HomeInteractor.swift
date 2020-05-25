//
//  HomeInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol HomeInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func calculateHome(home: Home)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?)
}

class HomeInteractorImpl: BaseInsuranceInteractor, HomeInteractor {
    
    
    private lazy var homePresenter = self.presenter as? HomePresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateHome(home: Home) {
        self.serviceFactory.networkManager.orders.request(.homeCalculate(home: home)) { [unowned self] r in
            self.homePresenter?.setLoading(isLoading: true)
            switch(r) {
            case .success(let response):
                self.homePresenter?.setLoading(isLoading: false)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response<InsuranceCalculatedResult>.self, from: response.data)
                    self.homePresenter?.setTotalAmount(amount: self.serviceFactory.formatter.decimalFormat(number: result.data?.totalAmount ?? 0))
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.homePresenter?.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.homePresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.homePresenter?.openHomeFinalVC()
            }
        }
    }
    
}


