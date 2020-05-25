//
//  AccidentConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class AccidentConfirmVC: BaseWithRightGreenCirclesVC {
        
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var accidentPresenter = self.presenter as? AccidentPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accidentPresenter?.fillConfirmData()
        self.accidentPresenter?.calculateAccident()
        backButtonClicked = { self.accidentPresenter?.goBack() }
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.accidentPresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        confirmButton.isLoading = isLoading
    }
    
    func setAmount(amount: String) {
        self.amount.text = amount
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmount.text = totalAmount
    }
    
}
