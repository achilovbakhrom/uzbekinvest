//
//  GasPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol GasPresenter {
    
    func openGas1VC()
    func openGas2VC()
    func openGas3vC()
    func openGasConfirmVC()
    func openGasFinalVC()
    func goBack()
    
    func setType(type: Int, typeString: String)
    func setFranchise(franchise: Int, franchiseString: String)
    func setInsuranceAmount(insuranceAmount: Int)
    func setLoading(isLoading: Bool)
    func setEnabled(isEnabled: Bool)
    func fillConfirmData()
    func setTotalAmount(totalAmount: String)
    func calculateGasHome()
    
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    
}

class GasPresenterImpl: BaseInsurancePresenter, GasPresenter {
    
    private lazy var gasRouter = self.router as? GasRouter
    private lazy var gasInteractor = self.interactor as? GasInteractor
    
    var franchiseString = ""
    var typeString = ""
    var gasHome: GasHome
    
    override init() {
        gasHome = GasHome()
    }
    
    func openGas1VC() {
        self.gasRouter?.openGas1VC()
    }
    
    func openGas2VC() {
        self.gasRouter?.openGas2VC()
    }
    
    func openGas3vC() {
        self.gasRouter?.openGas3VC()
    }
    
    func openGasConfirmVC() {
        self.gasRouter?.openGasConfirmVC()
    }
    
    func openGasFinalVC() {
        self.gasRouter?.openFinalVC()
    }
    
    func setType(type: Int, typeString: String) {
        self.gasHome.type = type
        self.typeString = typeString
        self.setEnabled(isEnabled: true)
    }
    
    func setFranchise(franchise: Int, franchiseString: String) {
        self.gasHome.franchise = franchise
        self.franchiseString = franchiseString
    }
    
    func setInsuranceAmount(insuranceAmount: Int) {
        self.gasHome.insuranceAmount = insuranceAmount
        self.setEnabled(isEnabled: insuranceAmount > 0)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? GasConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? Gas1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Gas3VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func fillConfirmData() {
        let vc = self.view as? GasConfirmVC
        vc?.setType(type: typeString)
        vc?.setService(service: self.franchiseString)
        vc?.setInsuranceAmount(insuranceAmount: "\(self.gasHome.insuranceAmount) \("sum".localized())")
    }
    
    func setTotalAmount(totalAmount: String) {
        self.formatAmount = "\(totalAmount) \("sum".localized())"
        let vc = self.view as? GasConfirmVC
        vc?.setTotalAmount(totalAmount: totalAmount)
    }
    
    func calculateGasHome() {
        self.gasInteractor?.calculateGasHome(gasHome: gasHome)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.gasInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.gasInteractor?.createInsurance(type: .gasHome, params: gasHome.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles, long: self.longitude, lat: self.lattitude)
    }
    
    
}
