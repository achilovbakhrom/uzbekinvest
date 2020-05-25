//
//  Registration1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit



class Registration1VC: BaseWithLeftCirclesVC {
    
    private lazy var registrationPresenter: RegistrationPresenter? = self.presenter as? RegistrationPresenter
    
    @IBOutlet weak var datePicker: DatePicker!
    
    @IBOutlet weak var name: TextField!

    var phone: String = ""
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.registrationPresenter?.openRegistration2VC()
    }
    
    @IBOutlet weak var nextButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.layer.opacity = 0.0
        self.datePicker.onChange = { self.registrationPresenter?.setDob(dob: $0) }
        self.registrationPresenter?.setup1()
        self.registrationPresenter?.setPhoneNumber(phone: self.phone)
    }
    
    @IBAction func nameDidChange(_ sender: TextField) {
        self.registrationPresenter?.setName(name: sender.text ?? "")
    }
    
    func setButtonEnabled(enabled: Bool) {
        self.nextButton.isEnabled = enabled
    }
    
    func setDob(date: String) {
        datePicker.text = date
    }
    
    func setName(name: String) {
        self.name.text = name
    }
}

