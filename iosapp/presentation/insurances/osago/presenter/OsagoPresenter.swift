//
//  OsagoPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol OsagoPresenter {
    func goBack()
    func openOsago1()
    func openOsago2()
    func openOsage3()
    func openOsage4()
    func openOsagoFinal()
    func openOsagoConfirm()
    func setIsForeigner(isForeigner: Bool)
    func setRegionId(regionId: Int, regionName: String)
    func setTransportId(transportId: Int, transportName: String)
    func setIsInvalid(isInvalid: Bool)
    func setIsRetired(isRetired: Bool)
    func setIsUnlim(isUnlim: Bool)
    func setMembersCount(membersCount: Int, membersCountString: String)
    func setPeriod(period: Int, periodName: String)
    func createOsago()
    func setRegions(regionList: [Region])
    func setLoading(isLoading: Bool)
    func setAccident(accident: Int)
    func fetchRegions()
    func fetchTransportList()
    func setTransportList(list: [Transport])
    func checkOsagoPeriod()
    func calculate(promocode: String)
    func fillConfirmVC()
    func setAmount(amount: Int, premiumAmount: Int)
    func applyInsuranceClicked()
    func setProduct(product: Product)
}

class OsagoPresenterImpl: BaseInsurancePresenter, OsagoPresenter {
    var osago: Osago
    var citizen: String!
    var region: String!
    var carType: String!
    var period: String!
    
    private lazy var osagoInteractor: OsagoInteractor = self.interactor as! OsagoInteractor
    
    var membersCountString: String = ""
    
    lazy var osagoRouter: OsagoRouter = self.router as! OsagoRouter
    
    override init() {
        self.osago = Osago()
    }
        
    func setProduct(product: Product) {
        self.product = product
    }
    
    func fetchRegions() {
        self.osagoInteractor.fetchRegionList()
    }
    
    func fetchTransportList() {
        self.osagoInteractor.fetchTransportList()
    }
    
    func setRegions(regionList: [Region]) {
        let vc = self.view as? Osago1VC
        vc?.setRegionList(regionList: regionList)
        vc?.setEnabled(isEnabled: self.osago.movementRegionId != -1)
        
    }
    
    func setIsForeigner(isForeigner: Bool) {
        self.osago.isForeigner = isForeigner
        if isForeigner {
            self.citizen = "foreign_citizen".localized()
        } else {
            self.citizen = "citizen_of_the_republic_of_uzbekistan".localized()
        }
    }
    
    func setRegionId(regionId: Int, regionName: String) {
        self.osago.movementRegionId = regionId
        self.region = regionName
        if let vc = self.view as? Osago1VC {
            vc.setEnabled(isEnabled: true)
        }
    }
    
    func setAccident(accident: Int) {
        self.osago.accident = accident
    }
    
    func setTransportId(transportId: Int, transportName: String) {
        self.osago.transportId = transportId
        self.carType = transportName
        let vc = self.view as? Osago2VC
        vc?.setEnabled(isEnabled: true)
    }
    
    func setIsInvalid(isInvalid: Bool) {
        self.osago.isInvalid = isInvalid
    }
    
    func setIsRetired(isRetired: Bool) {
        self.osago.isRetired = isRetired
    }
    
    func setIsUnlim(isUnlim: Bool) {
        self.osago.isUnlim = isUnlim
        self.osago.accident = isUnlim ? nil : 0
        self.osago.membersCount = nil
        self.membersCountString = "unlim".localized()
        let vc = self.view as? Osage3VC
        vc?.setEnabled(isEnabled: true)
    }
    
    func setMembersCount(membersCount: Int, membersCountString: String) {
        self.membersCount = membersCount
        self.osago.membersCount = membersCount
        self.membersCountString = membersCountString
        self.osago.isUnlim = false
        let vc = self.view as? Osage3VC
        vc?.setEnabled(isEnabled: true)
    }
    
    func setPeriod(period: Int, periodName: String) {
        self.period = periodName
        if osago.isForeigner {
            self.osago.period = period.toForeignPeriod()
        } else {
            self.osago.period = period.toUzbCitizenPeriod()
        }
        self.setEnabled(isEnabled: true)
    }
    
    func createOsago() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.osago.startDate = dateFormatter.string(from: Date())
        
    }
    
    func openOsago1() {
        self.osagoRouter.openOsago1VC()
    }
    
    func openOsago2() {
        self.osagoRouter.openOsago2VC()
    }
    
    func openOsage3() {
        self.osagoRouter.openOsago3VC()
    }
    
    func openOsage4() {
        self.osagoRouter.openOsago4VC()
    }
    
    func openOsagoConfirm() {
        self.osagoRouter.openOsagoConfirmVC()
    }
    
    func openOsagoFinal() {
        self.osagoRouter.openOsagoFinalVC()
    }
    
    func setTransportList(list: [Transport]) {
        let vc = self.view as? Osago2VC
        vc?.setTransportList(list: list)
        if list.count > 0  {
            let ti = list[0]
            ti.translates.forEach({ t in
                if t.lang == translateCode {
                    self.setTransportId(transportId: ti.id, transportName: t.name ?? "")
                }
            })            
        }
    }
    
    func setEnabled(isEnabled: Bool) {
           if let vc = self.view as? Osago1VC {
               vc.setEnabled(isEnabled: isEnabled)
           } else if let vc = self.view as? Osago2VC {
               vc.setEnabled(isEnabled: isEnabled)
           } else if let vc = self.view as? Osage3VC {
               vc.setEnabled(isEnabled: isEnabled)
           } else if let vc = self.view as? Osago4VC {
               vc.setEnabled(isEnabled: isEnabled)
           } else if let vc = self.view as? OsagoConfirm {
               vc.setEnabled(isEnabled: isEnabled)
           }
       }
    
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? Osago1VC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? Osago2VC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? Osage3VC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? Osago4VC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? OsagoConfirm {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func checkOsagoPeriod() {
        let vc = self.view as? Osago4VC
        let periodList = [0, 1, 2]
        if osago.isForeigner {
            vc?.setPeriod(ids: periodList, strings: periodList.map{$0.toForeignPeriodTitle()})
        } else {
            vc?.setPeriod(ids: periodList, strings: periodList.map{$0.toUzbCitizenPeriodTitle()})
        }
        
    }
    
    func calculate(promocode: String = "") {
        if !promocode.isEmpty {
            self.osago.promocode = promocode
        }
        self.osagoInteractor.calculateOsago(osago: self.osago)
    }
    
    func setAmount(amount: Int, premiumAmount: Int) {
        let vc = self.view as? OsagoConfirm
        self.totalAmount = premiumAmount
        self.formatAmount = "\(premiumAmount.toDecimalFormat()) \("sum".localized())"
        
        vc?.setAmount(amount: amount.toDecimalFormat(), premiumAmount: premiumAmount.toDecimalFormat())
    }
    
    func fillConfirmVC() {
        let vc  = self.view as? OsagoConfirm
        vc?.setCitizen(citizen: self.citizen)
        vc?.setRegion(region: self.region)
        vc?.setCarType(carType: self.carType)
        vc?.setMembersCount(membersCount: self.membersCountString)
        vc?.setPeriod(period: self.period)
    }
    
    func applyInsuranceClicked() {
        self.osagoInteractor.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        osago.paymentMethod = paymentType
        self.osagoInteractor.createInsurance(type: .osago, params: osago.dictionary!, amount: totalAmount, startDate: startDate, paymentMethod: self.paymentType, regionId: self.regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles, long: self.longitude, lat: self.lattitude)
    }
}
