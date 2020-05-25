//
//  Gas1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Gas1VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var type: DDown!
    
    @IBOutlet weak var nextButton: Button!
    
    private lazy var gasPresenter = self.presenter as? GasPresenter
        
    private lazy var typeData: ([Int], [String]) = {
        var ids = [Int]()
        var array = [String]()
        
        return ([0, 1], ["home".localized(), "third_party".localized()])
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        self.backButtonClicked = { self.gasPresenter?.goBack() }
        type.optionIds = typeData.0
        type.optionArray = typeData.1
        type.didSelect {
            self.gasPresenter?.setType(type: $2, typeString: $0)
        }
        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasPresenter?.openGas2VC()
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
}
