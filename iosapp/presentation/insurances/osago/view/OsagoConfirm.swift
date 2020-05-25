//
//  OsagoConfirm.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OsagoConfirm: BaseWithRightGreenCirclesVC {
    
    private lazy var osagoPresenter = self.presenter as? OsagoPresenter
    
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var citizen: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.osagoPresenter?.goBack()
        }
        self.osagoPresenter?.fillConfirmVC()
        self.osagoPresenter?.calculate()
    }
    
    func setAmount(amount: String) {
        self.amount.text = amount
    }
    
    func setCitizen(citizen: String) {
        self.citizen.text = citizen
    }
    
    func setRegion(region: String) {
        self.region.text = region
    }
    
    func setCarType(carType: String) {
        self.carType.text = carType
    }
    
    func setMembersCount(membersCount: String) {
        self.membersCount.text = membersCount
    }
    
    func setPeriod(period: String) {
        self.period.text = period
    }
    
    func setLoading(isLoading: Bool) {
        confirmButton.isLoading = isLoading
    }
    
    func setEnabled(isEnabled: Bool) {
        confirmButton.isEnabled = isEnabled
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.osagoPresenter?.applyInsuranceClicked()
    }
    
    
}
