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
    
    
    @IBOutlet weak var premiumAmountSumLabel: UILabel!
    @IBOutlet weak var premiumAmount: UILabel!
    @IBOutlet weak var premiumAmountHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var citizen: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var confirmButton: Button!
    @IBOutlet weak var amountSumLabel: UILabel!
    
    @IBOutlet weak var promocodeButton: OutlinedButton!
    
    @IBOutlet weak var stripeBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.osagoPresenter?.goBack()
        }
        self.premiumAmountSumLabel.text = "sum".localized()
        self.promocodeButton.setTitle("promocode".localized(), for: .normal)
        self.osagoPresenter?.fillConfirmVC()
        self.osagoPresenter?.calculate(promocode: "")
    }
    
    func setAmount(amount: String, premiumAmount: String) {
        self.amount.text = amount
        self.premiumAmount.text = premiumAmount
        if (premiumAmount == amount) {
            self.amount.removeStrikeThrough()
            self.amountSumLabel.removeStrikeThrough(forAbbr: true)
            self.premiumAmountSumLabel.isHidden = true
            self.premiumAmount.isHidden = true
            self.stripeBottomConstraint.constant = -20
        } else {
            self.amount.strikeThrough()
            self.amountSumLabel.strikeThrough(forAbbr: true)
            self.premiumAmountSumLabel.isHidden = false
            self.premiumAmount.isHidden = false
            self.stripeBottomConstraint.constant = 15
        }
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
    
    @IBAction func promocodeClickAction(_ sender: Any) {
        self.showPromocodeDialog()
    }
    
    override func onPromocodeAccept(promocode: String) {
        self.osagoPresenter?.calculate(promocode: promocode)
    }
}
