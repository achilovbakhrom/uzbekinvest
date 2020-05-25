//
//  LuggageConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class LuggageConfirmVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var luggagePresenter = self.presenter as? LuggagePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.luggagePresenter?.goBack() }
        self.luggagePresenter?.calculateLuggage()
        self.luggagePresenter?.fillData()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    func setTotalAmount(amount: String) {
        totalAmount.text = amount
    }
    
    func setDays(days: String) {
        self.days.text = days
    }
    
    func setInsuranceAmount(amount: String) {
        self.insuranceAmount.text = amount
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.luggagePresenter?.applyInsuranceClicked()
    }
    
}
