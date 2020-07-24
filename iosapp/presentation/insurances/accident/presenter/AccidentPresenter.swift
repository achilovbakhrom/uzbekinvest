//
//  AccidentPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol AccidentPresenter {
    func openAccident1VC()
    func setInsuranceAmount(amount: Int)
    func openAccidentConfirmVC()
    func openAccidentFinalVC()
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func fillConfirmData()
    func goBack()
    func calculateAccident()
    func setTotalAmount(amount: String)
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
}


class AccidentPresenterImpl: BaseInsurancePresenter, AccidentPresenter {
    
    var myHealth = MyHealth()
    
    private lazy var accidentRouter = router as? AccidentRouter
    private lazy var accidentInteractor = interactor as? AccidentInteractor
    
    func openAccident1VC() {
        accidentRouter?.openAccident1VC()
    }
    
    func setInsuranceAmount(amount: Int) {
        self.myHealth.type = amount
        self.setEnabled(isEnabled: amount >= 0)
    }
    
    func openAccidentConfirmVC() {
        accidentRouter?.openAccidentConfirmVC()
    }
    
    func openAccidentFinalVC() {
        self.accidentRouter?.openFinalVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        let vc = self.view as? Accident1VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? AccidentConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func fillConfirmData() {
        let vc = self.view as? AccidentConfirmVC
        vc?.setAmount(amount: "\(((myHealth.type + 1)*1000000).toDecimalFormat()) \("sum".localized())")
    }
    
    func calculateAccident() {
        self.accidentInteractor?.calculateAccident(myHealth: myHealth)
    }
    
    func setTotalAmount(amount: String) {
        self.formatAmount = "\(amount) \("sum".localized())"
        let vc = self.view as? AccidentConfirmVC
        vc?.setTotalAmount(totalAmount: amount)
    }
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.accidentInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.accidentInteractor?.createInsurance(type: .myHealth, params: myHealth.dictionary!, amount: totalAmount, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles, long: self.longitude, lat: self.lattitude)
    }
    
}
