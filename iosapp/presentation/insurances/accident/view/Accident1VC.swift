//
//  Accident1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Accident1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var amount: DDown!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var accidentPresenter = self.presenter as? AccidentPresenter
    
    private lazy var amountValues: ([Int], [String]) = {
        
        var idArray: [Int] = []
        var strArray: [String] = []
        (1...10).forEach {
            strArray.append("\(($0*1000000).toDecimalFormat()) \("sum".localized())")
            idArray.append($0)
        }
        return (idArray, strArray)
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amount.optionIds = amountValues.0
        amount.optionArray = amountValues.1
        amount.didSelect {
            self.accidentPresenter?.setInsuranceAmount(amount: $2-1)
        }
        nextButton.isEnabled = false
        backButtonClicked = { self.accidentPresenter?.goBack() }
        
        
    }
        
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.accidentPresenter?.openAccidentConfirmVC()
    }
        
}
