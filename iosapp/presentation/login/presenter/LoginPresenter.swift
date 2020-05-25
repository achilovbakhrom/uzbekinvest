//
//  RegistrationPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol: BasePresenter {
    func checkPhoneNumber(phoneNumber: String)
    func backPressed()
    func check(phone: String)
    func setLoading(loading: Bool)
    func goToRegistration(phone: String)
    func goToConfirm(phone: String)
}

class LoginPresenter: LoginPresenterProtocol {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    lazy var loginView: LoginVC? = {
        return self.view as? LoginVC
    }()
    
    lazy var loginRouter: LoginRouterProtocol? = {
        return self.router as? LoginRouterProtocol
    }()
    
    lazy var loginInteractor: LoginInteractorProtocol? = {
        return self.interactor as? LoginInteractorProtocol
    }()
    
    func checkPhoneNumber(phoneNumber: String) {
        self.loginView?.setEnabledNextButton(enabled: loginInteractor?.validatePhone(phone: phoneNumber) ?? false)
    }
    
    func backPressed() {
        self.loginRouter?.openSlider()
    }
    
    func check(phone: String) {
        let p = phone.digits
        let i = p.index(p.startIndex, offsetBy: 3)
        let finalPhone = p.suffix(from: i)
        self.loginInteractor?.checkPhoneNumberForExistance(phone: String(finalPhone))
    }
    
    func setLoading(loading: Bool) {
        self.loginView?.setLoading(loading: loading)
    }
    
    func goToRegistration(phone: String) {
        self.loginRouter?.openRegistration(phone: phone)
    }
    
    func goToConfirm(phone: String) {
        self.loginRouter?.openConfirm(phone: phone)
    }
}
