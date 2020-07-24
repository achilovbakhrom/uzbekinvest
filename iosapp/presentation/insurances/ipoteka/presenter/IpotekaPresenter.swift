//
//  IpotekaPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.

import Foundation
import UIKit

protocol IpotekaPresenter {
    func openIpoteka1VC()
    func openIpotekaConfirmVC()
    func openIpotekaFinalVC()
    func setYears(years: Int)
    func setInsuranceAmount(amount: Int)
    func fillConfirmData()
    func setLoading(isLoading: Bool)
    func calculateIpoteka()
    func setTotalAmount(amount: String)
    func goBack()
    func setProduct(product: Product)
    func openLoginVC(phone: String)
    func applyInsuranceClicked()
}

class IpotekaPresenterImpl: BaseInsurancePresenter, IpotekaPresenter {
    
    private var ipoteka: PledgedProperty
    
    override init() {
        ipoteka = PledgedProperty()
    }
    
    private lazy var ipotekaInteractor = self.interactor as? IpotekaInteractor
    private lazy var ipotekaRouter = self.router as? IpotekaRouter
    
    func openIpoteka1VC() {
        self.ipotekaRouter?.openIpoteka1()
    }
    
    func openIpotekaConfirmVC() {
        self.ipotekaRouter?.openIpotekaConfirmVC()
    }
    
    func openIpotekaFinalVC() {
        self.ipotekaRouter?.openFinalVC()
    }
    
    func setYears(years: Int) {
        ipoteka.years = years
        let isEnabled = ipoteka.years > 0 && ipoteka.insuranceAmount > 0
        let vc = self.view as? Ipoteka1VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setInsuranceAmount(amount: Int) {
        ipoteka.insuranceAmount = amount
        let isEnabled = ipoteka.years > 0 && ipoteka.insuranceAmount > 0
        let vc = self.view as? Ipoteka1VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func fillConfirmData() {
        let vc = self.view as? IpotekaConfirmVC
        vc?.setYears(years: "\(ipoteka.years)")
        vc?.setAmount(amount: "\(ipoteka.insuranceAmount.toDecimalFormat()) \("sum".localized())")
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? IpotekaConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func calculateIpoteka() {
        self.ipotekaInteractor?.calculateIpoteka(ipoteka: self.ipoteka)
    }
    
    func setTotalAmount(amount: String) {
        let vc = self.view as? IpotekaConfirmVC
        vc?.setTotalAmount(totalAmount: amount)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    func applyInsuranceClicked() {
        self.ipotekaInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.ipotekaInteractor?.createInsurance(type: .pledgedProperty, params: ipoteka.dictionary!, amount: totalAmount, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
