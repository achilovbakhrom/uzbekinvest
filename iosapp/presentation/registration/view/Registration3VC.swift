//
//  Registration3VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Registration3VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var phoneTextField: PhoneTextField!
    @IBOutlet weak var confirmCodeTextField: TextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var registrationPresenter: RegistrationPresenter = self.presenter as! RegistrationPresenter
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.isEnabled = false
        backButtonClicked = { self.registrationPresenter.goBack() }
        confirmCodeTextField.maskExpression = "{dddddd}"
        confirmCodeTextField.maskTemplate = "{dddddd}"
        confirmCodeTextField.onChange = {
            self.registrationPresenter.setConfirmCode(code: $0)
        }
        self.registrationPresenter.setup3()
        self.nextButton.isEnabled = false
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.registrationPresenter.acceptOffer()
    }
    
    func setPhoneNumber(phone: String) {
        phoneTextField.text = phone
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
    func setLoading3(isLoading: Bool) {
        nextButton.isLoading = isLoading
    }
    
}
