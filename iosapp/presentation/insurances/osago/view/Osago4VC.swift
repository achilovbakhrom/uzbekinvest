//
//  Osago4VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Osago4VC: BaseWithLeftCirclesVC {    
    
    @IBOutlet weak var term: DDown!
    @IBOutlet weak var nextButton: Button!
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
    @IBOutlet weak var policyDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        backButtonClicked = { self.osagoPresenter.goBack() }
        term.didSelect { self.osagoPresenter.setPeriod(period: $2, periodName: $0) }
        self.osagoPresenter.checkOsagoPeriod()
        self.policyDateLabel.text = "policy_date_label".localized()
    }
    
    func setLoading(isLoading: Bool) {
        nextButton.isLoading = isLoading
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
    func setPeriod(ids: [Int], strings: [String]) {
        term.optionIds = ids
        term.optionArray = strings
        term.text = strings[2]
        self.osagoPresenter.setPeriod(period: ids[2], periodName: strings[2])
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.osagoPresenter.openOsagoConfirm()
    }
    
}


