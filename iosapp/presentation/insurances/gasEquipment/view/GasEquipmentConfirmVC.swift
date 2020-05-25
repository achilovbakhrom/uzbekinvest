//
//  GasEquipmentConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class GasEquipmentConfirmVC: BaseWithLeftCirclesVC {
    
    private lazy var gasEquipmentPresenter = self.presenter as? GasEquipmentPresenter
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var equipment: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.gasEquipmentPresenter?.goBack()
        }
        self.gasEquipmentPresenter?.fillConfirmVC()
        self.gasEquipmentPresenter?.calculateGasEquipment()
        
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    @IBAction func conirmButtonClicked(_ sender: Any) {
        self.gasEquipmentPresenter?.applyInsuranceClicked()
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmount.text = totalAmount
    }
    
    func setType(type: String) {
        self.type.text = type
    }
    
    func setEquipment(equipment: String) {
        self.equipment.text = equipment
    }
    
    func setInsuranceAmount(amount: String) {
        self.insuranceAmount.text = amount
    }
    
}
