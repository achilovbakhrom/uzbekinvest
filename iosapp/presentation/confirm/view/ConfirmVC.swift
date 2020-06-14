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
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    private lazy var confirmPresenter = self.presenter as? ConfirmPresenter
    
    var phone: String = ""
    
    var timer: Timer!
    
    var hasStarted = false
    
    var remainingSeconds = 30
    
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
        if hasStarted {
            self.startTimer()
        }
    }
    
    private func startTimer()  {
        self.remainingSeconds = 30
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.remainingSeconds > 0 {
                self.timerLabel.isHidden = false
                self.resendButton.isHidden = true
                self.remainingSeconds = self.remainingSeconds - 1
                self.timerLabel.text = "\(self.remainingSeconds)"
            } else {
                self.timerLabel.isHidden = true
                self.resendButton.isHidden = false
                self.remainingSeconds = 0
                self.timerLabel.text = "\(self.remainingSeconds)"
                self.timer.invalidate()
                self.timer = nil
            }
        })
        self.timer.fire()
    }
    
    @IBAction func resendButtonClicked(_ sender: Any) {
        self.confirmPresenter?.resendCode()
        self.startTimer()
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
