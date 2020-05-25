//
//  MandatoryConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MandatoryConfirmVC: BaseWithRightGreenCirclesVC {
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.mandatoryPresenter?.goBack() }
        self.mandatoryPresenter?.fillConfirmVC()
        self.mandatoryPresenter?.calculateMandatory()
        
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.mandatoryPresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    func setTotalAmount(amount: String) {
        totalAmount.text = amount
    }
    
    func setExperience(exp: String) {
        experience.text = exp
    }
    
    func setAge(age: String) {
        self.age.text = age
    }
    
    func setInsuranceAmount(amount: String) {
        self.insuranceAmount.text = amount
    }
    
}
