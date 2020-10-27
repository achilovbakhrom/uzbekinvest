//
//  MandatoryConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MandatoryConfirmVC: BaseWithRightGreenCirclesVC {
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var amountSumLabel: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    
    @IBOutlet weak var premiumAmountLabel: UILabel!
    @IBOutlet weak var premiumAmountSumLabel: UILabel!
    @IBOutlet weak var bottomConstraint: UIView!
    @IBOutlet weak var promocodeButton: OutlinedButton!
    @IBOutlet weak var stripeConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.mandatoryPresenter?.goBack() }
        self.mandatoryPresenter?.fillConfirmVC()
        self.mandatoryPresenter?.calculateMandatory(promocode: "")
        self.promocodeButton.setTitle("promocode".localized(), for: .normal)
        self.premiumAmountSumLabel.text = "sum".localized()
        
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.mandatoryPresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    func setTotalAmount(amount: String, premiumAmount: String) {
        totalAmount.text = amount
        
        self.premiumAmountLabel.text = premiumAmount
        
        if (premiumAmount == amount) {
            self.totalAmount.removeStrikeThrough()
            self.amountSumLabel.removeStrikeThrough(forAbbr: true)
            self.premiumAmountSumLabel.isHidden = true
            self.premiumAmountLabel.isHidden = true
            self.stripeConstraint.constant = -20
        } else {
            self.totalAmount.strikeThrough()
            self.amountSumLabel.strikeThrough(forAbbr: true)
            self.premiumAmountSumLabel.isHidden = false
            self.premiumAmountLabel.isHidden = false
            self.stripeConstraint.constant = 15
        }
    }
    
    func setExperience(exp: String) {
        experience.text = exp
    }
    
    func setAge(age: String) {
        self.age.text = age
    }
    
    func setInsuranceAmount(amount: String) {
        self.insuranceAmount.text = amount
    }
    
    @IBAction func promocodeButtonClick(_ sender: Any) {
        self.showPromocodeDialog()
    }
    
    override func onPromocodeAccept(promocode: String) {
        self.mandatoryPresenter?.calculateMandatory(promocode: promocode)
    }
    
}
