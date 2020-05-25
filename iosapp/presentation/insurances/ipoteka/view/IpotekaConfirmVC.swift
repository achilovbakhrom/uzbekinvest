//
//  IpotekaVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class IpotekaConfirmVC: BaseWithRightGreenCirclesVC {
        
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var ipotekaPresenter = self.presenter as? IpotekaPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ipotekaPresenter?.fillConfirmData()
        self.ipotekaPresenter?.calculateIpoteka()
        backButtonClicked = { self.ipotekaPresenter?.goBack() }
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.ipotekaPresenter?.applyInsuranceClicked()
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmountLabel.text = totalAmount
    }
    
    func setYears(years: String) {
        self.yearsLabel.text = years
    }
    
    func setAmount(amount: String) {
        self.amountLabel.text = amount
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
}
