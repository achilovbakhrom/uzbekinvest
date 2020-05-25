//
//  MobilePhonePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MobilePhonePresenter {
    func openMobilePhone1VC()
    func openMobilePhoneConfirmVC()
    func openMobilePhoneFinalVC()
    func goBack()
    
    func setMobilePrice(price: Int)
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func fillConfirmData()
    func setTotalAmount(totalAmount: String)
    func calculateMobilePhone()
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    
}

class MobilePhonePresenterImpl: BaseInsurancePresenter, MobilePhonePresenter {
    
    
    private lazy var mobilePhoneRouter = self.router as? MobilePhoneRouter
    private lazy var mobilePhoneInteractor = self.interactor as? MobilePhoneInteractor
    
    var mobilePhone: MobilePhone
    
    var amountString: String = ""
    
    override init() {
        self.mobilePhone = MobilePhone()
    }
    
    func openMobilePhone1VC() {
        self.mobilePhoneRouter?.openMobilePhone1VC()
    }
    
    func openMobilePhoneConfirmVC() {
        self.mobilePhoneRouter?.openMobilePhoneConfirmVC()
    }
    
    func openMobilePhoneFinalVC() {
        self.mobilePhoneRouter?.openFinalVC()
    }
    
    func setMobilePrice(price: Int) {
        self.mobilePhone.phonePrice = price
        self.amountString = "\(price.toDecimalFormat()) \("sum".localized())"
        self.setEnabled(isEnabled: price > 0)
    }
    
    func setEnabled(isEnabled: Bool) {
        let vc = self.view as? MobilePhone1VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? MobilePhoneConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func fillConfirmData() {
        let vc = self.view as? MobilePhoneConfirmVC
        vc?.setMobilePrice(mobilePrice: self.amountString)
    }
    
    func setTotalAmount(totalAmount: String) {
        let vc = self.view as? MobilePhoneConfirmVC
        vc?.setTotalAmount(totalAmount: totalAmount)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func calculateMobilePhone() {
        self.mobilePhoneInteractor?.calculatePhone(mobilePhone: self.mobilePhone)
    }
    
    func applyInsuranceClicked() {
        self.mobilePhoneInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.mobilePhoneInteractor?.createInsurance(type: .phone, params: mobilePhone.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
