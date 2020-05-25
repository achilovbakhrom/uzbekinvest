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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        backButtonClicked = { self.osagoPresenter.goBack() }
        term.didSelect { self.osagoPresenter.setPeriod(period: $2, periodName: $0) }
        self.osagoPresenter.checkOsagoPeriod()
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
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.osagoPresenter.openOsagoConfirm()
    }
    
}
