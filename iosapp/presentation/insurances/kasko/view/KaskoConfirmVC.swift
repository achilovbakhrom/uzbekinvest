//
//  KaskoConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class KaskoConfirmVC: BaseWithRightGreenCirclesVC {
    
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var kaskoPresenter = self.presenter as? KaskoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.kaskoPresenter?.goBack() }
        self.kaskoPresenter?.fillConfirmVC()
        self.kaskoPresenter?.calculateKasko()
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.kaskoPresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    func setTotalAmount(amount: String) {
        self.totalAmountLabel.text = amount
    }
    
    func setType(type: String) {
        self.typeLabel.text = type
    }
    
    func setPeriod(period: String) {
        self.periodLabel.text = period
    }
    
    func setCarPrice(carPrice: String) {
        self.carPriceLabel.text = carPrice
    }

}
