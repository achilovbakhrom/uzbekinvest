//
//  Sport2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Sport2VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var insuranceAmount: DropDown!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    private lazy var amountData: ([Int], [String]) = {
        var ids: [Int] = []
        var array: [String] = []
        (1...10).forEach {
            ids.append($0 * 1000000)
            array.append("\(($0 * 1000000).toDecimalFormat()) сум")
        }
        return (ids, array)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        self.backButtonClicked = { self.sportsPresenter?.goBack() }
        self.insuranceAmount.optionIds = amountData.0
        self.insuranceAmount.optionArray = amountData.1
        
        self.insuranceAmount.didSelect {
            self.sportsPresenter?.setInsuranceAmount(insuranceAmount: $2)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.sportsPresenter?.openSport3VC()
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
}
