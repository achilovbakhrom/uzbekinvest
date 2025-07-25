//
//  ConfirmPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol ConfirmPresenter: BasePresenter {
    func setPhone(phone: String)
    func setConfirmCode(code: String)
    func confirmButtonClicked()
    func setEnabled(isEnabled: Bool)
    func resendCode()
    func setLoading(isLoading: Bool)
    func openMainPage()
    func showError(msg: String)
    func checkAndSetPhone(phoneMasked: String)
}

class ConfirmPresenterImpl: ConfirmPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    var phone: String = ""
    var confirmCode: Int!
    private lazy var confirmInteractor: ConfirmInteractor = self.interactor as! ConfirmInteractor
    private lazy var confirmRouter: ConfirmRouter = self.router as! ConfirmRouter
    private lazy var confirmView: ConfirmVC = self.view as! ConfirmVC
    
    func setPhone(phone: String) {
        self.phone = phone
    }
    
    func checkAndSetPhone(phoneMasked: String) {
        let p = phoneMasked.digits
        let i = p.index(p.startIndex, offsetBy: 3)
        let finalPhone = p.suffix(from: i)
        self.phone = String(finalPhone)
        
        var isEnabled = self.confirmInteractor.checkConfirmCode(code: String(confirmCode))
        
        if self.phone.count != 9 {
            isEnabled = false
        }
        setEnabled(isEnabled: isEnabled)
    }
    
    func confirmButtonClicked() {
        self.confirmInteractor.sendConfirmCode(phone: phone, code: confirmCode)
    }
    
    func setConfirmCode(code: String) {
        var isEnabled = self.confirmInteractor.checkConfirmCode(code: code)
        if isEnabled {
            confirmCode = Int(code) ?? 0
        } else {
            confirmCode = 0
        }
        if self.phone.count != 9 {
            isEnabled = false
        }
        setEnabled(isEnabled: isEnabled)
    }
    
    func setEnabled(isEnabled: Bool) {
        let vc = self.view as? ConfirmVC
        vc?.setEnabled(isEnabled: isEnabled)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? ConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func resendCode() {
        self.confirmInteractor.resendCode(phone: phone)
    }
    
    func openMainPage() {
        self.confirmRouter.openMainPage()
    }
    func showError(msg: String) {
        self.confirmView.showErrorMessage(msg: msg)
    }
 
}
