//
//  MobilePhoneConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MobilePhoneConfirmVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var totalAmoun5: UILabel!
    @IBOutlet weak var mobilePrice: UILabel!
    @IBOutlet weak var confirmButton: Button!
    private lazy var mobilePhonePresenter = self.presenter as? MobilePhonePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.mobilePhonePresenter?.goBack() }
        self.mobilePhonePresenter?.fillConfirmData()
        self.mobilePhonePresenter?.calculateMobilePhone()
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmoun5.text = totalAmount
    }
    
    func setMobilePrice(mobilePrice: String) {
        self.mobilePrice.text = mobilePrice
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.mobilePhonePresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
}
