//
//  HealthPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol HealthPresenter {
    func openHealth1VC()
    func openHealth2VC()
    func openHealthConfirmVC()
    func openHealthFinalVC()
    func goBack()
    func setType(type: Int, typeString: String)
    func setAge(age: Int, ageString: String)
    func setInsuranceAmount(insuranceAmount: Int)
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func calculate()
    func fillConfirmData()
    func setTotalAmount(totalAmount: String)
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
}

class HealthPresenterImpl: BaseInsurancePresenter, HealthPresenter {
    
    var typeString: String = ""
    var ageString: String = ""
    
    private lazy var healthRouter = self.router as? HealthRouter
    private lazy var healthInteractor = self.interactor as? HealthInteractor
    var health: MedicalInsurance
    
    override init() {
        health = MedicalInsurance()
    }
    
    func openHealth1VC() {
        self.healthRouter?.openHealth1VC()
    }
    
    func openHealth2VC() {
        self.healthRouter?.openHealth2VC()
    }
    
    func openHealthConfirmVC() {
        self.healthRouter?.openHealthConfirmVC()
    }
    
    func openHealthFinalVC() {
        self.healthRouter?.openFinalVC()
    }
    
    func setType(type: Int, typeString: String) {
        self.health.type = type
        self.typeString = typeString
    }
    
    func setAge(age: Int, ageString: String) {
        self.health.age = age
        self.ageString = ageString
        setEnabled(isEnabled: true)
    }
    
    func setInsuranceAmount(insuranceAmount: Int) {
        self.health.insuranceAmount = insuranceAmount        
        self.setEnabled(isEnabled: insuranceAmount >= 500000 && insuranceAmount <= 5000000)
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? Health1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Health2VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? HealthConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func calculate() {
        self.healthInteractor?.calculate(health: self.health)
    }
    
    func fillConfirmData() {
        let vc = self.view as? HealthConfirmVC
        vc?.setType(type: typeString)
        vc?.setAge(age: ageString)
        vc?.setInsuranceAmount(insuranceAmount: "\(self.health.insuranceAmount?.toDecimalFormat() ?? "0") сум")
    }
    
    func setTotalAmount(totalAmount: String) {
        let vc = self.view as? HealthConfirmVC
        vc?.setTotalAmount(totalAmount: Double(totalAmount)?.toDecimalFormat() ?? "0")
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.healthInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.healthInteractor?.createInsurance(type: .medical, params: health.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
    
}
