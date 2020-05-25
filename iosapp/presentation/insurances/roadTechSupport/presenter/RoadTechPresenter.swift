//
//  RoadTechPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol RoadTechPresenter {
    
    func openTechRoad1VC()
    func openTechRoadConfirmVC()
    func openTechRoadFinalVC()
    func goBack()
    
    func setInsuranceAmount(insuranceAmount: Int)
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func calculateTechnicalSupport()
    func fillConfirmData()
    func setTotalAmount(totalAmount: String)
    
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    
}

class RoadTechPresenterImpl: BaseInsurancePresenter, RoadTechPresenter {
    
    
    private lazy var roadTechRouter = self.router as? RoadTechRouter
    private lazy var roadTechInteractor = self.interactor as? RoadTechInteractor
    
    var technicalSupport: TechnicalSupport
    override init() {
        technicalSupport = TechnicalSupport()
    }
    
    func openTechRoad1VC() {
        self.roadTechRouter?.openTechRoad1VC()
    }
    
    func openTechRoadConfirmVC() {
        self.roadTechRouter?.openTechRoadConfirmVC()
    }
    
    func openTechRoadFinalVC() {
        self.roadTechRouter?.openFinalVC()
    }
    
    func setInsuranceAmount(insuranceAmount: Int) {
        self.technicalSupport.insuranceAmount = insuranceAmount
        self.setEnabled(isEnabled: insuranceAmount > 300000 && insuranceAmount < 1000000)
    }
    
    func setEnabled(isEnabled: Bool) {
        let vc = self.view as? RoadTechSupport1VC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? RoadTechSupportConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func calculateTechnicalSupport() {
        self.roadTechInteractor?.calculateTechnicalSupport(technicalSupport: self.technicalSupport)
    }
    
    func fillConfirmData() {
        let vc = self.view as? RoadTechSupportConfirmVC
        vc?.setInsuranceAmount(insuranceAmount: "\(self.technicalSupport.insuranceAmount.toDecimalFormat()) \("sum".localized())")
    }
    
    func setTotalAmount(totalAmount: String) {
        let vc = self.view as? RoadTechSupportConfirmVC
        vc?.setTotalAmount(totalAmount: totalAmount)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.roadTechInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
        
    }
    
    override func confirmButtonClicked() {
        self.roadTechInteractor?.createInsurance(type: .technicalHelp, params: technicalSupport.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
