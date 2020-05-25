//
//  IpotekaVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Ipoteka1VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var years: SimpleTextField!
    @IBOutlet weak var amount: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var ipotekaPresenter = self.presenter as? IpotekaPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.years.onChange = {
            self.ipotekaPresenter?.setYears(years: Int($0) ?? 0)
        }
        self.amount.onChange = {
            self.ipotekaPresenter?.setInsuranceAmount(amount: Int($0) ?? 0)
        }
        self.backButtonClicked = {
            self.ipotekaPresenter?.setYears(years: 0)
            self.ipotekaPresenter?.goBack()
        }
        self.nextButton.isEnabled = false
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.ipotekaPresenter?.openIpotekaConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}

