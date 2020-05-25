//
//  Osago3VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit



class Osage3VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var driversCountDropDown: DDown!
    @IBOutlet weak var conditionsDropDown: DDown!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionsDropDown.isHidden = true
        self.setEnabled(isEnabled: false)
        driversCountDropDown.optionArray = ["unlim".localized(), "1", "2", "3", "4", "5"]
        driversCountDropDown.optionIds = [0, 1, 2, 3, 4, 5]
        driversCountDropDown.didSelect { name, _, id in
            if id == 0 {
                self.conditionsDropDown.isHidden = true
                self.osagoPresenter.setIsUnlim(isUnlim: true)
                
            } else {
                self.conditionsDropDown.isHidden = false
                self.osagoPresenter.setIsUnlim(isUnlim: false)
                self.osagoPresenter.setMembersCount(membersCount: id, membersCountString: name)
                self.osagoPresenter.setAccident(accident: 0)
            }
        }
        conditionsDropDown.optionArray = [
            "no_incident".localized(),
            "one_incident".localized(),
            "two_incidents".localized(),
            "three_or_more".localized()
        ]
        conditionsDropDown.optionIds = [0, 1, 2, 3]
        nextButton.isEnabled = false
        backButtonClicked = { self.osagoPresenter.goBack() }
        conditionsDropDown.didSelect { (_, _, conditionCount) in
            self.osagoPresenter.setAccident(accident: conditionCount)
        }
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.osagoPresenter.openOsage4()
    }
    
    func setLoading(isLoading: Bool) {
        self.nextButton.isLoading = isLoading
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}
