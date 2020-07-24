//
//  MobilePhone1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MobilePhone1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var mobilePhone: SimpleTextField!
    private lazy var mobilePhonePresenter = self.presenter as? MobilePhonePresenter
    @IBOutlet weak var nextButton: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {}
        self.nextButton.isEnabled = false
        backButtonClicked = {
            self.mobilePhonePresenter?.goBack()
        }
        mobilePhone.onChange = {
            self.mobilePhonePresenter?.setMobilePrice(price: Int($0) ?? 0)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.mobilePhonePresenter?.openMobilePhoneConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}
