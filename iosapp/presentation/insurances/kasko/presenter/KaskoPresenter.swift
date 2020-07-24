//
//  KaskoPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol KaskoPresenter {
    func openKasko1()
    func openKasko2()
    func openKaskoConfirmVC()
    func openKaskoFinal()
    func goBack()
    func setLoading(isLoading: Bool)
    func setEnabled(isEnabled: Bool)
    func setType(type: Int, typeString: String)
    func setCarPrice(price: Int)
    func setPeriod(period: Float, periodString: String)
    func setTotalAmount(amount: String, amoutnDouble: Double)
    func fillConfirmVC()
    func calculateKasko()
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    func setProduct(product: Product)
    func setup2VC()
}

class KaskoPresenterImpl: BaseInsurancePresenter, KaskoPresenter {
    
    
    private lazy var kaskoInteractor = self.interactor as? KaskoInteractor
    private lazy var kaskoRouter = self.router as? KaskoRouter
    
    private var typeString = ""
    private var carPriceString = ""
    private var periodString = ""
    
    var kasko: Kasko
    override init() {
        self.kasko = Kasko()
    }
    
    func openKasko1() {
        self.kaskoRouter?.openKasko1VC()
    }
    
    func openKasko2() {
        self.kaskoRouter?.openKasko2VC()
    }
    
    func openKaskoConfirmVC() {
        self.kaskoRouter?.openKaskoConfirmVC()
    }
    
    func openKaskoFinal() {
        self.kaskoRouter?.openFinalVC()
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? KaskoConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func setEnabled(isEnabled: Bool) {
        let vc = self.view as? Kasko2VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setType(type: Int, typeString: String) {
        self.kasko.type = type
        self.typeString = typeString
    }
    
    func setCarPrice(price: Int) {
        self.kasko.carPrice = price
        carPriceString = "\(price.toDecimalFormat()) \("sum".localized())"
        let vc = self.view as? Kasko2VC
        vc?.setEnabled(isEnabled: kasko.period != 0)
    }
    
    func setPeriod(period: Float, periodString: String) {
        self.kasko.period = period
        self.periodString = periodString
        
        let vc = self.view as? Kasko2VC
        vc?.setEnabled(isEnabled: kasko.carPrice != 0)
    }
    
    func setTotalAmount(amount: String, amoutnDouble: Double) {
        let vc = self.view as? KaskoConfirmVC
        vc?.setTotalAmount(amount: amount)
        self.totalAmount = Int(amoutnDouble)
        self.formatAmount = "\(amount) \("sum".localized())"
    }
    
    func fillConfirmVC() {
        let vc = self.view as? KaskoConfirmVC
        vc?.setType(type: typeString)
        vc?.setPeriod(period: periodString)
        vc?.setCarPrice(carPrice: carPriceString)
    }
    
    func applyInsuranceClicked() {
        self.kaskoInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    func calculateKasko() {
        self.kaskoInteractor?.calculateKasko(kasko: self.kasko)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    override func confirmButtonClicked() {
        self.kaskoInteractor?.createInsurance(type: .kasko, params: kasko.dictionary!, amount: totalAmount, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles, long: self.longitude, lat: self.lattitude)
    }
    
    func setup2VC() {
        let vc = self.view as? Kasko2VC
        if kasko.type == 3 {
            vc?.setTitles(titles: ["kasko_1_year".localized()])
            vc?.setPeriodValues(periodValues: [1.0])
            vc?.setIds(ids: [0])
        } else {
            vc?.setTitles(titles: [
                "kasko_3_months".localized(),
                "kasko_6_months".localized(),
                "kasko_9_months".localized(),
                "kasko_1_year".localized(),
                "kasko_2_years".localized(),
                "kasko_3_years".localized(),
                "kasko_4_years".localized(),
                "kasko_5_years".localized()
            ])
            vc?.setPeriodValues(periodValues: [0.25, 0.5, 0.75, 1.0, 2.0, 3.0, 4.0, 5.0])
            vc?.setIds(ids: [0, 1, 2, 3, 4, 5, 6])
        }
    }
    
}
