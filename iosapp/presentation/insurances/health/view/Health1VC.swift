//
//  HealthVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Health1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var classicButton: UIButton!
    @IBOutlet weak var prestigeButton: UIButton!
    @IBOutlet weak var prestigePlusButton: UIButton!
    @IBOutlet weak var age: DDown!
    
    @IBOutlet weak var nextButton: Button!
    
    private lazy var healthPresenter = self.presenter as? HealthPresenter
    
    private lazy var ageData: ([Int], [String]) = {
        let ids = [0, 1, 2, 3, 4, 5, 6, 7]
        let array = [
            "until_3".localized(),
            "from_3_to_7".localized(),
            "from_7_to_16".localized(),
            "from_16_to_35".localized(),
            "from_35_to_45".localized(),
            "from_45_to_55".localized(),
            "from_55_to_70".localized(),
            "from_70".localized()
        ]
        return (ids, array)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.classicButton.active()
        self.prestigeButton.inactive()
        self.prestigePlusButton.inactive()
        self.healthPresenter?.setType(type: 0, typeString: classicButton.titleLabel?.text ?? "")
        self.nextButton.isEnabled = false
        self.age.optionIds = self.ageData.0
        self.age.optionArray = self.ageData.1        
        self.age.didSelect {
            self.healthPresenter?.setAge(age: $2, ageString: $0)
        }
        backButtonClicked = { self.healthPresenter?.goBack() }
    }
    
    @IBAction func classicButtonClicked(_ sender: Any) {
        self.classicButton.active()
        self.prestigeButton.inactive()
        self.prestigePlusButton.inactive()
        self.healthPresenter?.setType(type: 0, typeString: classicButton.titleLabel?.text ?? "")
    }
    
    @IBAction func prestigeButtonClicked(_ sender: Any) {
        self.classicButton.inactive()
        self.prestigeButton.active()
        self.prestigePlusButton.inactive()
        self.healthPresenter?.setType(type: 1, typeString: prestigeButton.titleLabel?.text ?? "")
    }
    
    @IBAction func prestigePlusButtonClicked(_ sender: Any) {
        self.classicButton.inactive()
        self.prestigeButton.inactive()
        self.prestigePlusButton.active()
        self.healthPresenter?.setType(type: 2, typeString: prestigePlusButton.titleLabel?.text ?? "")
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.healthPresenter?.openHealth2VC()
    }
    
    
}
