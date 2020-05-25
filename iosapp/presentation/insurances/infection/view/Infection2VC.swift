//
//  Infection2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Infection2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var lt7: SimpleTextField!
    @IBOutlet weak var lt60: SimpleTextField!
    @IBOutlet weak var lt100: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var infectionPresenter = self.presenter as? InfectionPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        backButtonClicked = { self.infectionPresenter?.goBack() }
        lt7.onChange = { self.infectionPresenter?.setLt7(count: Int($0) ?? 0) }
        lt60.onChange = { self.infectionPresenter?.setLt60(count: Int($0) ?? 0) }
        lt100.onChange = { self.infectionPresenter?.setMte60(count: Int($0) ?? 0)}
        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.infectionPresenter?.openInfectionConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
}
