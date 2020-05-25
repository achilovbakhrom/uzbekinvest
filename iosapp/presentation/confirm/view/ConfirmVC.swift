//
//  ConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class ConfirmVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var phoneTextField: PhoneTextField!
    @IBOutlet weak var confirmTextField: TextField!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var confirmPresenter = self.presenter as? ConfirmPresenter
    
    var phone: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmTextField.maskExpression = "{dddddd}"
        self.confirmTextField.maskExpression = "******"
        
        if phone.count > 1 {
            self.phoneTextField.text = phone.substring(from: 1)
            self.confirmPresenter?.setPhone(phone: phone)
        }
        
        self.confirmTextField.onChange = { self.confirmPresenter?.setConfirmCode(code: $0) }
        self.confirmTextField.keyboardType = .phonePad
        self.phoneTextField.keyboardType = .phonePad
        confirmButton.isEnabled = false
        backButton.isHidden = true
    }
    
    @IBAction func resendButtonClicked(_ sender: Any) {
        self.confirmPresenter?.resendCode()
    }
    
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.confirmPresenter?.confirmButtonClicked()
    }
    
    
    func setEnabled(isEnabled: Bool) {
        self.confirmButton.isEnabled = isEnabled
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
}
