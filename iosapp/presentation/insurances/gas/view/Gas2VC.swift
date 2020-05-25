//
//  Gas2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Gas2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var first: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var third: UIButton!
    private lazy var gasPresenter = self.presenter as? GasPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        first.active()
        second.inactive()
        third.inactive()
        self.gasPresenter?.setFranchise(franchise: 0, franchiseString: first.titleLabel?.text ?? "")
        self.backButtonClicked = { self.gasPresenter?.goBack() }
        
    }
    
    @IBAction func firstClicked(_ sender: Any) {
        first.active()
        second.inactive()
        third.inactive()
        self.gasPresenter?.setFranchise(franchise: 0, franchiseString: first.titleLabel?.text ?? "")
    }
    
    @IBAction func secondClicked(_ sender: Any) {
        first.inactive()
        second.active()
        third.inactive()
        self.gasPresenter?.setFranchise(franchise: 1, franchiseString: second.titleLabel?.text ?? "")
    }
    
    @IBAction func thirdClicked(_ sender: Any) {
        first.inactive()
        second.inactive()
        third.active()
        self.gasPresenter?.setFranchise(franchise: 2, franchiseString: third.titleLabel?.text ?? "")
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasPresenter?.openGas3vC()
    }
    
}
