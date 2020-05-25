//
//  TravelPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol TravelPresenter {
    func openTravel1VC()
    func openTravel2VC()
    func openTravel3VC()
    func openTravel4VC()
    func openTravel5VC()
    func openTravelConfirm1VC()
    func openTravelConfirm2VC()
    func openTravelFinalVC()
    func goBack()
    func fetchCountryList()
    func setProduct(product: Product)
    func addCountry(country: Country)
    func removeCountry(country: Country)
    func setupTravel2VC()
    func setInsuranceAmount(insuranceAmount: Int, insuranceAmountString: String)
    func setPlan(plan: Int, planString: String)
    func setType(type: Int, typeString: String)
    func setTravelStartDate(startDate: String)
    func setTravelEndDate(endDate: String)
    func setPurpose(purpose: Int, purposeString: String)
    func setClassOfPurpose(clazz: String)
    func showError(msg: String)
    func setLoading(isLoading: Bool)
    func setEnabled(isEnabled: Bool)
    func setCountryList(list: [Country])
    func checkCountry(id: Int) -> Bool
    func travel4VCNextButtonClicked()
    func fetchTypes()
    func setSport(sports: [SportModel])
    func setWork(work: [Work])
    func remove(memberAt: Int)
    func addMember()
    func setDob(at: Int, dob: String)
    func initTouristsList1VC()
    func fillConfirm1VC()
    func setMultiType(type: Int)
    func travel5ButtonClicked()
    func calculate()
    func setTotalAmount(amount: Double)
    func initTravelConfirm2VC()
    func setTouristName(at: Int, name: String)
    func setTouristDob(at: Int, dob: String)
    func setTouristPassport(at: Int, passport: String)
    func applyInsuranceClicked()
}

class TravelPresenterImpl: BaseInsurancePresenter, TravelPresenter {
    
    var countryList: [Country] = []
    var zone = 0
    var isShengen = false
    var travel: Travel = Travel()
    var purposeString: String = ""
    var inusranceAmountString = ""
    var planString = ""
    var typeString = ""
    private lazy var travelInteractor = self.interactor as? TravelInteractor
    private lazy var travelRouter = self.router as? TravelRouter
    var touristList: [Tourist]  = []
    func openTravel1VC() {
        self.travelRouter?.openTravel1VC()
    }
    
    func openTravel2VC() {
        self.travel.countries = self.countryList.map({ $0.id ?? 0 })
        self.travelRouter?.openTravel2VC()
    }
    
    func openTravel3VC() {
        self.travelRouter?.openTravel3VC()
    }
    
    func openTravel4VC() {
        self.travelRouter?.openTravel4VC()
    }
    
    func openTravel5VC() {
        self.travelRouter?.openTravel5VC()
    }
    
    func openTravelConfirm1VC() {
        self.travelRouter?.openTravelConfirm1VC()
    }
    
    func openTravelConfirm2VC() {
        self.travelRouter?.openTravelConfirm2VC()
    }
    
    func openTravelFinalVC() {
        self.travelRouter?.openFinalVC()
    }
    
    func fetchCountryList() {
        self.travelInteractor?.fetchCountryList()
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func addCountry(country: Country) {
        var found = false
        self.countryList.forEach {
            if $0.id == country.id {
                found = true
                return
            }
        }
        if !found {
            self.countryList.append(country)
            self.defineZone()
        }
    }
    
    func removeCountry(country: Country) {
        var counter = 0
        var found = false
        self.countryList.forEach {
            if !found {
                if $0.id == country.id {
                    found = true                    
                } else {
                    counter += 1
                }
            }
        }
        self.countryList.remove(at: counter)
        self.defineZone()
    }
    
    private func defineZone() {
        self.zone = 0
        self.isShengen = false
        self.countryList.forEach {
            if ($0.zone ?? 0) >= zone {
                zone = $0.zone ?? 0
            }
            if !isShengen { self.isShengen = $0.isShengen == 1 }
        }
    }
    
    func setupTravel2VC() {
        if let vc = self.view as? Travel2VC {
            vc.setZone(isZoneOne: self.zone == 0, isShengen: self.isShengen)
        }
    }
    
    func setInsuranceAmount(insuranceAmount: Int, insuranceAmountString: String) {
        self.travel.insuranceAmount = insuranceAmount
        self.inusranceAmountString = insuranceAmountString
    }
    
    func setPlan(plan: Int, planString: String) {
        self.travel.plan = plan
        self.planString = planString
    }
    
    func setType(type: Int, typeString: String) {
        self.travel.type = type
        self.typeString = typeString
        self.travel.members?.removeAll()
        self.travel.members?.append(Member(dob: ""))
        if type == 0 {
            setEnabled(isEnabled: false)
        } else {
            self.travel.members?.append(Member(dob: ""))
            setEnabled(isEnabled: true)
        }
    }
    
    func setMultiType(type: Int) {
        self.travel.type = type
        self.setEnabled(isEnabled: (type == 0 && travel.startDate != nil && travel.endDate != nil) || type == 1)
    }
    
    func setDob(at: Int, dob: String) {
        self.travel.members?[at].dob = dob
        
        if self.view is Travel5VC {
            if travel.type != 0 {
                self.setEnabled(isEnabled: true)
            } else {
                var found = false
                travel.members?.forEach {
                    if $0.dob == "" && !found {
                        found = true
                    }
                }
                setEnabled(isEnabled: !found)
            }
        } else {
            var found = false
            travel.members?.forEach {
                if $0.dob == "" && !found {
                    found = true
                }
            }
            setEnabled(isEnabled: !found)
        }
    }
    
    func setTravelEndDate(endDate: String) {
        self.travel.endDate = endDate
        self.setEnabled(isEnabled: travel.startDate != nil && travel.endDate != nil)
    }
    
    func setTravelStartDate(startDate: String) {
        self.travel.startDate = startDate
        self.setEnabled(isEnabled: travel.startDate != nil && travel.endDate != nil)
    }
    
    func setPurpose(purpose: Int, purposeString: String) {
        self.travel.purpose = purpose
        self.purposeString = purposeString
    }
    
    func setClassOfPurpose(clazz: String) {
        self.travel.clazz = clazz
    }
    
    func showError(msg: String) {
        if let vc = self.view as? BaseViewImpl {
            vc.showErrorMessage(msg: msg)
        }
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? Travel1VC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? TravelConfirm1VC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? Travel1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Travel3VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Travel5VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? TouristList1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? TravelConfirm2VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func setCountryList(list: [Country]) {
        if let vc = self.view as? Travel1VC {
            vc.setCountryList(countryList: list.filter({ return !($0.translates?.isEmpty ?? false) }))
        }
    }
    
    func checkCountry(id: Int) -> Bool {
        var found = false
        countryList.forEach {
            if $0.id == id {
                found = true
                return
            }
        }
        return found
    }
    
    func travel4VCNextButtonClicked() {
        if travel.purpose == 0 { // open next page
            self.travelRouter?.openTravel5VC()
        } else { // open select travel type page
            self.travelRouter?.openSelectTypeVC()
        }
    }
    
    func fetchTypes() {
        if travel.purpose == 1 { // work
            self.travelInteractor?.fetchWork()
        } else if travel.purpose == 2 { //sport
            self.travelInteractor?.fetchSports()
        }
    }
    
    func setSport(sports: [SportModel]) {
        let filtered = sports.filter({ $0.group != nil })
        var result: [TravelTypeGroup] = []
        filtered.forEach { sport in
            var found = false
            for i in (0..<result.count) {
                if result[i].group == sport.group {
                    result[i].types.append(TravelType(id: sport.id, name: sport.name ?? ""))
                    found = true
                    break
                }
            }
            if !found {
                result.append(TravelTypeGroup(group: sport.group ?? "", types: [TravelType(id: sport.id, name: sport.name ?? "")]))
            }
        }
        
        if let vc = self.view as? TravelSelectTypeVC {
            let sorted = result.sorted { (t1, t2) -> Bool in
                t1.group < t2.group
            }
            vc.setTravelGroup(group: sorted)
        }
    }
    
    
    func setWork(work: [Work]) {
        let filtered = work.filter({ $0.group != nil })
        var result: [TravelTypeGroup] = []
        filtered.forEach { work in
            var found = false
            for i in (0..<result.count) {
                if result[i].group == work.group {
                    result[i].types.append(TravelType(id: work.id, name: work.name ?? ""))
                    found = true
                    break
                }
            }
            if !found {
                result.append(TravelTypeGroup(group: work.group ?? "", types: [TravelType(id: work.id, name: work.name ?? "")]))
            }
        }
        
        if let vc = self.view as? TravelSelectTypeVC {
            let sorted = result.sorted { (t1, t2) -> Bool in
                t1.group < t2.group
            }
            vc.setTravelGroup(group: sorted)
        }
    }
    
    func remove(memberAt: Int) {
        self.travel.members?.remove(at: memberAt)
        var found = false
        travel.members?.forEach {
            if $0.dob == "" && !found {
                found = true
            }
        }
        setEnabled(isEnabled: !(travel.members?.isEmpty ?? false) && !found)
        if let vc = self.view as? TouristList1VC {
            vc.setMembers(members: self.travel.members ?? [])
        }
        self.membersCount = (self.travel.members?.isEmpty ?? false) ? 0 : (self.travel.members?.count ?? 0) - 1
    }
    
    
    
    func addMember() {
        self.travel.members?.append(Member(dob: ""))
        var found = false
        travel.members?.forEach {
            if $0.dob == "" && !found {
                found = true
            }
        }
        setEnabled(isEnabled: !found)
        if let vc = self.view as? TouristList1VC {
            vc.setMembers(members: self.travel.members ?? [])
        }
        self.membersCount = (self.travel.members?.isEmpty ?? false) ? 0 : (self.travel.members?.count ?? 0) - 1
    }
    
    func initTouristsList1VC() {
        if let vc = self.view as? TouristList1VC {
            vc.setMembers(members: travel.members ?? [])
        }
        self.membersCount = (self.travel.members?.isEmpty ?? false) ? 0 : (self.travel.members?.count ?? 0) - 1
    }
    
    func fillConfirm1VC() {
        if let vc = self.view as? TravelConfirm1VC {
            let c = self.countryList.map({ $0.translates?[translatePosition]?.name ?? "" }).joined(separator: ", ")
            vc.setCountry(country: c)
            
            vc.setAmount(amount: "\(self.travel.insuranceAmount.toDecimalFormat()) €")
            vc.setTariff(tariff: planString)
            vc.setType(type: typeString)
            vc.setPurpose(purpose: purposeString)
            vc.setGroupType(type: typeString)
        }
    }
    
    func travel5ButtonClicked() {
        if travel.type == 0 {
            self.openTravelConfirm1VC()
        } else {
            self.travelRouter?.openTouristsList1VC()
        }
    }
    
    func calculate() {
        self.travelInteractor?.calculateTravel(travel: self.travel)
    }
    
    func setTotalAmount(amount: Double) {        
        if let vc = self.view as? TravelConfirm1VC {
            vc.setTotalAmount(amount: amount.toDecimalFormat())
        }
    }
    
    func initTravelConfirm2VC() {
        touristList = self.travel.members!.map({ m in
            return Tourist(id: nil, dob: m.dob, name: "", passportNumber: "")
        })
        if let vc = self.view as? TravelConfirm2VC {
            vc.setTouristsList(list: touristList)
        }
    }
    
    func setTouristName(at: Int, name: String) {
        self.touristList[at].name = name
        self.setEnabled(isEnabled: isTouristsListValid())
    }
    func setTouristDob(at: Int, dob: String) {
        self.touristList[at].dob = dob
        self.setEnabled(isEnabled: isTouristsListValid())
    }
    func setTouristPassport(at: Int, passport: String) {
        self.touristList[at].passportNumber = passport
        self.setEnabled(isEnabled: isTouristsListValid())
    }
    
    private func isTouristsListValid() -> Bool {
        var found = false
        self.touristList.forEach { t in
            if t.name.isEmpty || t.dob.isEmpty || t.passportNumber.isEmpty {
                found = true
            }
        }
        return !found
    }
    
    func applyInsuranceClicked() {
        self.travelInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.travel.members = nil
        self.travel.countries = nil
        var travelDict = self.travel.dictionary!
        for index in (0..<touristList.count) {
            let t = touristList[index]
            travelDict["members[\(index)][name]"] = t.name
            travelDict["members[\(index)][dob]"] = t.dob
            travelDict["members[\(index)][passport_number]"] = t.passportNumber
        }
        
        for index in (0..<countryList.count) {
            travelDict["countries[\(index)]"] = countryList[index].id
        }
        
        self.travelInteractor?.createInsurance(type: .travel, params: travelDict, amount: nil, startDate: startDate, paymentMethod: self.paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
