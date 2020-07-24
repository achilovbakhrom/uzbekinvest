//
//  KaskoInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
protocol KaskoInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BaseInsurancePresenter)
    func calculateKasko(kasko: Kasko)
    func prepareToOpenFinalVC(id: Int)
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]?, long: Double, lat: Double)
}

class KaskoInteractorImpl: BaseInsuranceInteractor, KaskoInteractor {
    
    
    private lazy var kaskoPresenter = self.presenter as? KaskoPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BaseInsurancePresenter) {
        super.init()
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func calculateKasko(kasko: Kasko) {
        self.serviceFactory.networkManager.orders.request(.kaskoCalculate(kasko: kasko), completion: {
            self.kaskoPresenter?.setLoading(isLoading: true)
            switch $0 {
            case .success(let resonse):
                self.kaskoPresenter?.setLoading(isLoading: false)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response<TravelInusranceResult>.self, from: resonse.data)
                    self.kaskoPresenter?.setTotalAmount(amount: "\(result.data?.totalAmount.toDecimalFormat() ?? "0.0")", amoutnDouble: result.data?.totalAmount ?? 0.0)
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                self.kaskoPresenter?.setLoading(isLoading: false)
                debugPrint(error.localizedDescription)
                break
            }
        })
    }
    
    func prepareToOpenFinalVC(id: Int) {
        self.fetchDocumentsByProductid(id: id) { isLoading in
            self.kaskoPresenter?.setLoading(isLoading: isLoading)
            if !isLoading {
                self.kaskoPresenter?.openKaskoFinal()
            }
        }
    }
    
}
