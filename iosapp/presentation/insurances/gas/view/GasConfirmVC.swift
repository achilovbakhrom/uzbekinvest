//
//  GasConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class GasConfirmVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var confirmButton: Button!
    private lazy var gasPresenter = self.presenter as? GasPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gasPresenter?.fillConfirmData()
        self.gasPresenter?.calculateGasHome()
        backButtonClicked = { self.gasPresenter?.goBack() }

    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmount.text = totalAmount
    }
    
    func setType(type: String) {
        self.type.text = type
    }
    
    func setService(service: String) {
        self.service.text = service
    }
    
    func setInsuranceAmount(insuranceAmount: String) {
        self.insuranceAmount.text = insuranceAmount
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    @IBAction func confirmButtonCLicked(_ sender: Any) {
        self.gasPresenter?.openGasFinalVC()
    }
    
    
}
