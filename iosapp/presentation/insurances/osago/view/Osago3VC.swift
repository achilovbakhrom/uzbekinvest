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
    @IBOutlet weak var membersCountLabel: UILabel!
    @IBOutlet weak var accidentConditionDesc: UILabel!
    
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        driversCountDropDown.optionArray = ["unlim".localized(), "1", "2", "3", "4", "5"]
        driversCountDropDown.optionIds = [0, 1, 2, 3, 4, 5]
        driversCountDropDown.didSelect { name, _, id in
            if id == 0 {
                self.conditionsDropDown.isHidden = true
                self.accidentConditionDesc.isHidden = true
                self.osagoPresenter.setIsUnlim(isUnlim: true)
            } else {
                self.conditionsDropDown.isHidden = false
                self.accidentConditionDesc.isHidden = false
                self.conditionsDropDown.text = "no_incident".localized()
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
        
        driversCountDropDown.text = "unlim".localized()
        self.osagoPresenter.setIsUnlim(isUnlim: true)
        conditionsDropDown.isHidden = true
        accidentConditionDesc.isHidden = true
        self.setEnabled(isEnabled: false)
        
        conditionsDropDown.optionIds = [0, 1, 2, 3]
        nextButton.isEnabled = true
        backButtonClicked = { self.osagoPresenter.goBack() }
        conditionsDropDown.didSelect { (_, _, conditionCount) in
            self.osagoPresenter.setAccident(accident: conditionCount)
        }
        membersCountLabel.text = "members_count_desc".localized()
        accidentConditionDesc.text = "accident_title_osago".localized()
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
