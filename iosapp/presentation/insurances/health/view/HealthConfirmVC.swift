//
//  HealthVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class HealthConfirmVC: BaseWithRightGreenCirclesVC {
    
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var insuranceAmountLabel: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var healthPresenter = self.presenter as? HealthPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.healthPresenter?.fillConfirmData()
        self.healthPresenter?.calculate()
        backButtonClicked = { self.healthPresenter?.goBack() }
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmountLabel.text = totalAmount
    }
    
    func setType(type: String) {
        self.typeLabel.text = type
    }
    
    func setAge(age: String) {
        self.ageLabel.text = age
    }
    
    func setInsuranceAmount(insuranceAmount: String){
        self.insuranceAmountLabel.text = insuranceAmount
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.healthPresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
}
