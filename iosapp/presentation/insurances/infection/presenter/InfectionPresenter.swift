//
//  InfectionPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol InfectionPresenter {
    
    func openInfection1VC()
    func openInfection2VC()
    func openInfectionConfirmVC()
    func openInfectionFinalVC()
    func goBack()
    
    func setInsuranceAmount(insuranceAmount: Int)
    func setLt7(count: Int)
    func setLt60(count: Int)
    func setMte60(count: Int)
    func setLoading(isLoading: Bool)
    func setEnabled(isEnabled: Bool)
    func fillConfirmData()
    func calculateInfection()
    func setTotalAmount(totalAmount: String)
    
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
}

class InfectionPresenterImpl: BaseInsurancePresenter, InfectionPresenter {
    
    var infection: Infection
    
    private lazy var infectionRouter = self.router as? InfectionRouter
    private lazy var infectionInteractor = self.interactor as? InfectionInteractor
    
    override init() {
        self.infection = Infection()
    }
    
    func openInfection1VC() {
        self.infectionRouter?.openInfection1VC()
    }
    
    func openInfection2VC() {
        self.infectionRouter?.openInfection2VC()
    }
    
    func openInfectionConfirmVC() {
        self.infectionRouter?.openInfectionConfirmVC()
    }
    
    func openInfectionFinalVC() {
        self.infectionRouter?.openFinalVC()
    }
    
    
    func setInsuranceAmount(insuranceAmount: Int) {
        self.infection.insuranceAmount = insuranceAmount
        self.setEnabled(isEnabled: insuranceAmount > 0)
    }
    
    private func checkMembersCount() -> Bool {
        return (infection.quantityLt7 + infection.quantityLt60 + infection.quantityMte60) > 0
        
    }
    
    func setLt7(count: Int) {
        self.infection.quantityLt7 = count
        self.setEnabled(isEnabled: checkMembersCount())
    }
    
    func setLt60(count: Int) {
        self.infection.quantityLt60 = count
        self.setEnabled(isEnabled: checkMembersCount())
    }
    
    func setMte60(count: Int) {
        self.infection.quantityMte60 = count
        self.setEnabled(isEnabled: checkMembersCount())
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? InfectionConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? Infection1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Infection2VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func fillConfirmData() {
        let vc = self.view as? InfectionConfirmVC
        vc?.setInsuranceAmount(insuranceAmount: "\(self.infection.insuranceAmount) \("sum".localized())")
    }
    
    func calculateInfection() {
        self.infectionInteractor?.calculateInfection(infection: self.infection)
    }
    
    func setTotalAmount(totalAmount: String) {
        let vc = self.view as? InfectionConfirmVC
        vc?.setTotalAmount(totalAmount: totalAmount)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.infectionInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.infectionInteractor?.createInsurance(type: .infection, params: infection.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
