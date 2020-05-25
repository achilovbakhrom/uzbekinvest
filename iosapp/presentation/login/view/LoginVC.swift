//
//  RegistrationPhoneVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit


class LoginVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var phoneTextField: PhoneTextField!
    
    lazy var loginPresenter: LoginPresenterProtocol? = {
        return self.presenter as? LoginPresenterProtocol
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        self.phoneTextField.onChange = { self.loginPresenter?.checkPhoneNumber(phoneNumber: $0) }
        self.backButtonClicked = { self.loginPresenter?.backPressed() }
    }
    
    @IBAction
    func nextButtonClicked(_ sender: Any) {
        self.loginPresenter?.check(phone: phoneTextField.text!)
    }
    
    func setLoading(loading: Bool) {
        self.nextButton.isLoading = loading
    }
    
    func setEnabledNextButton(enabled: Bool) {
        self.nextButton.isEnabled = enabled
    }
}
