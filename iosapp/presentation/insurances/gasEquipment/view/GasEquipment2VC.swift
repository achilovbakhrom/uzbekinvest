//
//  GasEquipment2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class GasEquipment2VC: BaseWithLeftCirclesVC {
    
    private lazy var gasEquipmentPresenter = self.presenter as? GasEquipmentPresenter
    
    @IBOutlet weak var car: UIButton!
    @IBOutlet weak var other: UIButton!
    @IBOutlet weak var insuranceAmount: DDown!
    @IBOutlet weak var thirdPartyAmount: DDown!
    @IBOutlet weak var nextButton: Button!
    
    private var isCarType = true
    
    private var insuranceAmountData: ([Int], [String]) {
        get {
            var ids: [Int] = []
            if self.isCarType {
                ids = [1, 2, 3, 5].map({ $0 * 1000000})
            } else {
                ids = [3, 6, 9, 15].map({ $0 * 1000000})
            }
            return (ids, ids.map({ "\($0.toDecimalFormat()) \("sum".localized())" }))
        }
    }
    
    private var thirdPartyAmountData: ([Int], [String]) {
        get {
            let ids = [1, 2, 3, 5, 8, 10]
            return (ids, ids.map({ $0.toDecimalFormat() }))
        }
    }
    
    func setGasEquipmentMode() {
        self.car.isHidden = false
        self.other.isHidden = false
        self.thirdPartyAmount.isHidden = true
    }
    
    func setThirdPartyMode() {
        self.car.isHidden = true
        self.other.isHidden = true
        self.thirdPartyAmount.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gasEquipmentPresenter?.setupGasEquipment2VC()
        self.backButtonClicked = { self.gasEquipmentPresenter?.goBack() }
        
        self.car.active()
        self.other.inactive()
        self.gasEquipmentPresenter?.setType(type: 0, typeString: self.car.titleLabel?.text ?? "")
        self.nextButton.isEnabled = false
        insuranceAmount.optionIds = insuranceAmountData.0
        insuranceAmount.optionArray = insuranceAmountData.1
        insuranceAmount.didSelect {
            self.gasEquipmentPresenter?.setFirstPartyAmount(amount: $2)
        }
        
        thirdPartyAmount.optionIds = insuranceAmountData.0
        thirdPartyAmount.optionArray = insuranceAmountData.1
        thirdPartyAmount.didSelect {
            self.gasEquipmentPresenter?.setThirdPartyAmount(amount: $2)
        }
    }
    
    @IBAction func carButtonClicked(_ sender: Any) {
        self.car.active()
        self.other.inactive()
        self.isCarType = true
        self.gasEquipmentPresenter?.setType(type: 0, typeString: self.car.titleLabel?.text ?? "")
    }
    
    @IBAction func otherClicked(_ sender: Any) {
        self.car.inactive()
        self.other.active()
        self.isCarType = false
        self.gasEquipmentPresenter?.setType(type: 1, typeString: self.other.titleLabel?.text ?? "")
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasEquipmentPresenter?.openGasEquipmentConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}
