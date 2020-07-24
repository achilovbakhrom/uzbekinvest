//
//  MandatoryPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MandatoryPresenter {
    func goBack()
    func openMandatory1()
    func openMandatory2()
    func openMandatoryConfirmVC()
    func openMandatoryFinalVC()
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func setExperience(exp: Int, expString: String)
    func setAge(age: Int, ageString: String)
    func setInsuranceAmount(amount: Int, amountString: String)
    func fillConfirmVC()
    func setTotalAmount(formatAmount: String, totalAmount: Int)
    func calculateMandatory()
    func setProduct(product: Product)
    func setDocuments(documents: DocsResponse)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
}

class MandatoryPresenterImpl: BaseInsurancePresenter, MandatoryPresenter {
    
    private lazy var mandatoryInteractor = self.interactor as? MandatoryInteractor
    private lazy var mandatoryRouter = self.router as? MandatoryRouter
    private var pledgedTransport = PledgedTransport()
    private var experienceString: String = ""
    private var ageString: String = ""
    private var amountString: String = ""
    
    
    override init() {
        super.init()
        self.experienceString = "less_than_22".localized()
        self.ageString = "less_than_22".localized()
        self.membersCount = 0
    }
    
    func openMandatory1() {
        self.mandatoryRouter?.openMandatory1()
    }
    
    func openMandatory2() {
        self.mandatoryRouter?.openMandatory2()
    }
    
    func openMandatoryConfirmVC() {
        self.mandatoryRouter?.openMandatoryConfirmVC()
    }
    
    func applyInsuranceClicked() {
        self.mandatoryInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    func openMandatoryFinalVC() {
        self.mandatoryRouter?.openFinalVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        let vc = self.view as? Mandatory2VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? MandatoryConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func setExperience(exp: Int, expString: String) {
        self.pledgedTransport.experience = exp
        self.experienceString = expString
    }
    
    func setAge(age: Int, ageString: String) {
        self.pledgedTransport.age = age
        self.ageString = ageString
    }
    
    func setInsuranceAmount(amount: Int, amountString: String) {
        self.pledgedTransport.insuranceAmount = amount
        self.amountString = amountString
        self.setEnabled(isEnabled: true)
    }
    
    func fillConfirmVC() {
        let vc = self.view as? MandatoryConfirmVC
        vc?.setAge(age: ageString)
        vc?.setExperience(exp: experienceString)
        vc?.setInsuranceAmount(amount: amountString)
    }
    
    func setTotalAmount(formatAmount: String, totalAmount: Int) {
        let vc = self.view as? MandatoryConfirmVC
        self.totalAmount = totalAmount
        self.formatAmount = formatAmount
        vc?.setTotalAmount(amount: formatAmount)
    }
    
    func calculateMandatory() {
        self.mandatoryInteractor?.calculateMandatory(pledgedTransport: self.pledgedTransport)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    override func confirmButtonClicked() {
        self.mandatoryInteractor?.createInsurance(type: .pledgedTransport, params: pledgedTransport.dictionary!, amount: nil, startDate: startDate, paymentMethod: self.paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
