//
//  GasPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol GasEquipmentPresenter {
    func openGasEquipment1VC()
    func openGasEquipment2VC()
    func openGasEquipmentConfirmVC()
    func openGasEquipmentFinalVC()
    func goBack()
    
    
    func setupGasEquipment2VC()
    func setType(type: Int, typeString: String)
    func setFirstPartyAmount(amount: Int)
    func setThirdPartyAmount(amount: Int)
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    
    func setIsGasEquipment(isGasEquipment: Bool, isGasEquipmentString: String)
    func fillConfirmVC()
    func calculateGasEquipment()
    func setTotalAmount(amount: Int)
    
}


class GasEquipmentPresenterImpl: BaseInsurancePresenter, GasEquipmentPresenter {
    
    private lazy var gasEquipmentRouter = self.router as? GasEquipmentRouter
    private lazy var gasEquipmentInteractor = self.interactor as? GasEquipmentInteractor
    
    private var typeString = ""
    
    var isGasEquipment = true
    var isGasEquipmentString = ""
    
    var gasAuto: GasAuto!
    
    override init() {
        self.gasAuto = GasAuto()
    }
    
    func openGasEquipment1VC() {
        self.gasEquipmentRouter?.openGasEquipment1VC()
    }
    
    func openGasEquipment2VC() {
        self.gasEquipmentRouter?.openGasEquipment2VC()
    }
    
    func setupGasEquipment2VC() {
        let vc = self.view as? GasEquipment2VC
        if isGasEquipment {
            vc?.setGasEquipmentMode()
        } else {
            vc?.setThirdPartyMode()
        }
    }
    
    func setIsGasEquipment(isGasEquipment: Bool, isGasEquipmentString: String) {
        self.isGasEquipment = isGasEquipment
        self.isGasEquipmentString = isGasEquipmentString
        self.setEnabled(isEnabled: true)
    }
    
    func openGasEquipmentConfirmVC() {
        self.gasEquipmentRouter?.openGasEquipmentConfirmVC()
    }
    
    func openGasEquipmentFinalVC() {
        self.gasEquipmentRouter?.openFinalVC()
    }
    
    func setType(type: Int, typeString: String) {
        self.gasAuto.firstPartyType = type
        self.setEnabled(isEnabled: true)
    }
    
    func setFirstPartyAmount(amount: Int) {
        self.gasAuto.firstPartyAmount = amount
        self.gasAuto.thirdPartyAmount = nil
        self.setEnabled(isEnabled: amount > 0)
    }
    
    func setThirdPartyAmount(amount: Int) {
        self.gasAuto.thirdPartyAmount = amount
        self.gasAuto.firstPartyAmount = nil
        self.setEnabled(isEnabled: amount > 0)
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? GasEquipment1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? GasEquipment2VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? GasEquipmentConfirmVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func applyInsuranceClicked() {
        self.gasEquipmentInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    func fillConfirmVC() {
        if let vc = self.view as? GasEquipmentConfirmVC {
            vc.setType(type: isGasEquipmentString)
            if isGasEquipment {
                vc.setInsuranceAmount(amount: "\(self.gasAuto.firstPartyAmount?.toDecimalFormat() ?? "0") \("sum".localized())")
                vc.setEquipment(equipment: typeString)
            } else {
                vc.setInsuranceAmount(amount: "\(self.gasAuto.thirdPartyAmount?.toDecimalFormat() ?? "0") \("sum".localized())")
                vc.setEquipment(equipment: "-")
            }
        }
    }
    
    func calculateGasEquipment() {
        self.gasEquipmentInteractor?.calculateGasEquipment(gasAuto: self.gasAuto)
    }
    
    func setTotalAmount(amount: Int) {
        self.totalAmount = amount
        if let vc = self.view as? GasEquipmentConfirmVC {
            vc.setTotalAmount(totalAmount: "\(amount.toDecimalFormat())")
        }
    }
    
    override func confirmButtonClicked() {        
        self.gasEquipmentInteractor?.createInsurance(type: .gasAuto, params: gasAuto.dictionary!, amount: nil, startDate: startDate, paymentMethod: self.paymentType, regionId: self.regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
