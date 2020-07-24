//
//  LuggagePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/7/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol LuggagePresenter {
    func openLuggage1VC()
    func openLuggage2VC()
    func openLuggageConfirmVC()
    func openLuggageFinalVC()
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func goBack()
    
    func setDay(day: Int, dayString: String)
    func setInsuranceAmount(amount: Int, amountString: String)
    func calculateLuggage()
    func setTotalAmount(totalAmount: Int)
    
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    func fillData()
}

class LuggagePresenterImpl: BaseInsurancePresenter, LuggagePresenter {
    
    private lazy var luggageRouter = self.router as? LuggageRouter
    private lazy var luggageInteractor = self.interactor as? LuggageInteractor
    private var luggage: Luggage!
    private var dayString: String!
    private var amountString: String!
    override init() {
        luggage = Luggage()
    }
    
    func openLuggage1VC() {
        self.luggageRouter?.openLuggage1VC()
    }
    
    func openLuggage2VC() {
        self.luggageRouter?.openLuggage2VC()
    }
    
    func openLuggageConfirmVC() {
        self.luggageRouter?.openLuggageConfirmVC()
    }
    
    func openLuggageFinalVC() {
        self.luggageRouter?.openFinalVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? Luggage1VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? LuggageConfirmVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func setDay(day: Int, dayString: String) {
        luggage.days = day
        self.dayString = dayString
        self.setEnabled(isEnabled: true)
    }
    
    func setInsuranceAmount(amount: Int, amountString: String) {
        self.luggage.insuranceAmount = amount
        self.amountString = amountString
    }
    
    func calculateLuggage() {
        self.luggageInteractor?.calculateLuggage(luggage: self.luggage)
    }
    
    func setTotalAmount(totalAmount: Int) {
        self.formatAmount = "\(totalAmount.toDecimalFormat()) \("sum".localized())"
        self.totalAmount = totalAmount
        if let vc = self.view as? LuggageConfirmVC {
            vc.setTotalAmount(amount: totalAmount.toDecimalFormat())
        }
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.luggageInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.luggageInteractor?.createInsurance(type: .luggage, params: luggage.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles, long: self.longitude, lat: self.lattitude)
    }
    
    func fillData() {
        if let vc = self.view as? LuggageConfirmVC {
            vc.setTotalAmount(amount: self.totalAmount.toDecimalFormat())
            vc.setDays(days: dayString)
            vc.setInsuranceAmount(amount: amountString)
        }
    }
}
