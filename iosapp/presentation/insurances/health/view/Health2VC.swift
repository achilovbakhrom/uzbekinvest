//
//  HealthVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Health2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var insuranceAmount: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var healthPresenter = self.presenter as? HealthPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insuranceAmount.onChange = {
            self.healthPresenter?.setInsuranceAmount(insuranceAmount: Int($0) ?? 0)
        }
        backButtonClicked = { self.healthPresenter?.goBack() }
        nextButton.isEnabled = false
        insuranceAmount.floatText = "".localized()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.healthPresenter?.openHealthConfirmVC()
    }
    
}
