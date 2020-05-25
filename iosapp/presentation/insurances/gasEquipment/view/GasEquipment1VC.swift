//
//  GasEquipment1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class GasEquipment1VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var type: DDown!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var gasEquipmentPresenter = self.presenter as? GasEquipmentPresenter
    
    private lazy var typeData: ([Int], [String]) = (
        [0, 1],
        ["gas_equipment".localized(), "third_party".localized()]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type.optionIds = typeData.0
        type.optionArray = typeData.1
        type.didSelect {
            self.gasEquipmentPresenter?.setIsGasEquipment(isGasEquipment: $2 == 0, isGasEquipmentString: $0)
        }
        backButtonClicked = {
            self.gasEquipmentPresenter?.setIsGasEquipment(isGasEquipment: true, isGasEquipmentString: "")
            self.gasEquipmentPresenter?.goBack()
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasEquipmentPresenter?.openGasEquipment2VC()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}
