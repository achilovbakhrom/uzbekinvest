//
//  Mandatory2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Mandatory2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var insuranceAmount: DDown!
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    
    private lazy var list: (Array<String>, Array<Int>) = {
        var ids: Array<Int> = []
        var option: Array<String> = []
        (1...10).forEach {
            ids.append($0*1000000)
            option.append("\(($0*1000000).toDecimalFormat()) \("sum".localized())")
            
        }
        return (option, ids)
    }()
    
    @IBOutlet weak var nextButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.mandatoryPresenter?.goBack() }
        self.nextButton.isEnabled = false        
        self.insuranceAmount.optionArray = list.0
        self.insuranceAmount.optionIds = list.1
        self.insuranceAmount.didSelect {
            self.mandatoryPresenter?.setInsuranceAmount(amount: $2, amountString: $0)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.mandatoryPresenter?.openMandatoryConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
}
