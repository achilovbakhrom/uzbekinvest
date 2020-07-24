//
//  RoadTechSupport1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class RoadTechSupport1VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var insuranceAmount: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var roadTechPresenter = self.presenter as? RoadTechPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.roadTechPresenter?.goBack() }
        insuranceAmount.onChange = {
            self.roadTechPresenter?.setInsuranceAmount(insuranceAmount: Int($0) ?? 0)
        }
        insuranceAmount.placeholder = "insurance_amount_title".localized()
        nextButton.isEnabled = false
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.roadTechPresenter?.openTechRoadConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
}
