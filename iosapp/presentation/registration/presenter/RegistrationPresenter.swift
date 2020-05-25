//
//  RegistrationPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/15/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationPresenter: BasePresenter {
    func setName(name: String)
    func setDob(dob: Date)
    func setRegion(region: Int)
    func setAddress(address: String)
    func sendCode()
    func setPhoneNumber(phone: String)
    func setConfirmCode(code: String)
    func acceptOffer()
    func openRegistration1VC()
    func openRegistration2VC()
    func openRegistration3VC()
    func openOfferVC()
    func openDashboard()
    func goBack()
    func setup1()
    func setup2()
    func setup3()
    func setLoading2(enabled: Bool)
    func setLoading3(enabled: Bool)
    func setRegions(regions: [Region])
}

class RegistrationPresenterImpl: RegistrationPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    var user: User!
    
    init() { user = User() }
    
    private lazy var registrationInteractor: RegistrationInteractor = self.interactor as! RegistrationInteractor
    
    private lazy var registrationRouter: RegistrationRouter = self.router as! RegistrationRouter
    
    private lazy var registrationView: Registration1VC = self.view as! Registration1VC
    
    func setName(name: String) {
        let v = self.view as? Registration1VC
        user.name = name
        v?.setButtonEnabled(enabled: user.name != "" && user.dob != "")
    }
    
    func setDob(dob: Date) {
        let v = self.view as? Registration1VC
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        user.dob = dateFormatter.string(from: dob)
        v?.setButtonEnabled(enabled: !(user?.name.isEmpty ?? false) && !(user?.dob?.isEmpty ?? false))
    }
    
    func setRegion(region: Int) {
        if user?.region != nil {
            user?.region?.id = region
        } else {
            var r = Region()
            r.id = region
            user?.region = r
        }
//        user.region = region
        let vc = self.view as? Registration2VC
        vc?.setEnabled(enabled: user?.region != nil && !(user?.address?.isEmpty ?? false))
    }
    
    func setAddress(address: String) {
        user.address = address
        let vc = self.view as? Registration2VC
        vc?.setEnabled(enabled: user.region != nil && !(user?.address?.isEmpty ?? false))
    }
    
    func setPhoneNumber(phone: String) {
        user.phone = Int(phone)
    }
    
    func sendCode() {
        registrationInteractor.sendCode(phone: String(user?.phone ?? 0))
    }
    
    func setConfirmCode(code: String) {
        let confirmCodeIsValid = registrationInteractor.checkConfirmCode(code: code)
        if confirmCodeIsValid {
            self.user.code = Int(code) ?? 0
        }
        let vc = self.view as? Registration3VC
        vc?.setEnabled(isEnabled: confirmCodeIsValid)
    }
    
    func accept() {
        
    }
    
    func acceptOffer() {
        self.registrationInteractor.register(user: self.user)
    }
    
    func goBack() {
        self.registrationRouter.goBack()
    }
    
    func openRegistration1VC() {
        self.registrationRouter.openRegistration1()
    }
    
    func openRegistration2VC() {
        self.registrationRouter.openRegistration2()
    }
    
    func openRegistration3VC() {
        self.registrationRouter.openRegistration3()
    }
    
    func openOfferVC() {
        self.registrationRouter.openOfferVC()
    }
    
    func openDashboard() {
        self.registrationRouter.openDashboard()
    }
    
    func setup1() {
        if let pn = self.registrationInteractor.getInitPhoneNumber() { user.phone = Int(pn) }
        registrationView.setDob(date: user?.dob ?? "")
        registrationView.setName(name: user.name)
        registrationView.setButtonEnabled(enabled: !(user?.dob?.isEmpty ?? false) && !(user?.name.isEmpty ?? false))
    }
    
    func setup2() {
        if registrationInteractor.regions.count == 0 {
            registrationInteractor.fetchRegions()
        }
    }
    
    func setup3() {
        let vc = self.view as! Registration3VC
        vc.setPhoneNumber(phone: String(user.phone ?? 998).substring(from: 1))
    }
    
    func setLoading2(enabled: Bool) {
        let vc = self.view as? Registration2VC
        vc?.setLoading(isLoading: enabled)
    }
    
    func setLoading3(enabled: Bool) {
        let vc = self.view as! OfferVC
        vc.setLoading(isLoading: enabled)
    }
    
    func setEnabled2(enabled: Bool) {
        let vc = self.view as? Registration2VC
        vc?.setEnabled(enabled: enabled)
    }
    
    func setRegions(regions: [Region]) {
        let vc = self.view as? Registration2VC
        vc?.setRegions(list: regions)
        
    }
    
}
