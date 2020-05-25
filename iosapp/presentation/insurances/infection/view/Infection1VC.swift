//
//  Infection1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Infection1VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var insuranceAmount: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var infectionPresenter = self.presenter as? InfectionPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.infectionPresenter?.goBack() }
        self.nextButton.isEnabled = false
        self.insuranceAmount.onChange = {
            self.infectionPresenter?.setInsuranceAmount(insuranceAmount: Int($0) ?? 0)
        }
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.infectionPresenter?.openInfection2VC()
    }
    
}
