//
//  Sport3VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Sport3VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var lt15: SimpleTextField!
    @IBOutlet weak var lt18: SimpleTextField!
    @IBOutlet weak var lt30: SimpleTextField!
    @IBOutlet weak var mte30: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        self.backButtonClicked = { self.sportsPresenter?.goBack() }
        lt15.onChange = { self.sportsPresenter?.setLt15(count: Int($0) ?? 0) }
        lt18.onChange = { self.sportsPresenter?.setLt18(count: Int($0) ?? 0) }
        lt30.onChange = { self.sportsPresenter?.setLt30(count: Int($0) ?? 0) }
        mte30.onChange = { self.sportsPresenter?.setMte30(count: Int($0) ?? 0) }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.sportsPresenter?.openSport4VC()
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
}
