//
//  Luggage2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Luggage2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var fifHundredButton: UIButton!
    @IBOutlet weak var sevenHundredButton: UIButton!
    @IBOutlet weak var thousandButton: UIButton!
    
    private lazy var luggagePresenter = self.presenter as? LuggagePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.select500()
        self.backButtonClicked = { self.luggagePresenter?.goBack() }
    }
    
    @IBAction func fifHundredAction(_ sender: Any) {
        self.select500()
    }
    
    @IBAction func sevenHundredAction(_ sender: Any) {
        self.select700()
    }
    
    @IBAction func thousandAction(_ sender: Any) {
        self.select1000()
    }
    
    func select500() {
        self.fifHundredButton.active()
        self.sevenHundredButton.inactive()
        self.thousandButton.inactive()
        self.luggagePresenter?.setInsuranceAmount(amount: 500, amountString: "500$")
    }
    
    func select700() {
        self.fifHundredButton.inactive()
        self.sevenHundredButton.active()
        self.thousandButton.inactive()
        self.luggagePresenter?.setInsuranceAmount(amount: 700, amountString: "500$")
    }
    
    func select1000() {
        self.fifHundredButton.inactive()
        self.sevenHundredButton.inactive()
        self.thousandButton.active()
        self.luggagePresenter?.setInsuranceAmount(amount: 1000, amountString: "1000$")
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.luggagePresenter?.openLuggageConfirmVC()
    }
    
}
