//
//  Gas3VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Gas3VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var insuranceAmount: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    private lazy var gasPresenter = self.presenter as? GasPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.gasPresenter?.goBack() }
        nextButton.isEnabled = false
        insuranceAmount.onChange = { self.gasPresenter?.setInsuranceAmount(insuranceAmount: Int($0) ?? 0) }
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasPresenter?.openGasConfirmVC()
    }
    
}
