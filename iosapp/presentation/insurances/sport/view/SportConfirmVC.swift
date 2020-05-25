//
//  SportConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class SportConfirmVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var sport: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsPresenter?.fillConfirmData()
        self.sportsPresenter?.calculateSports()
        self.backButtonClicked = { self.sportsPresenter?.goBack() }
    }
    
    func setPeriod(period: String) {
        self.period.text = period
    }
    
    func setMemebersCount(membersCount: String) {
        self.membersCount.text = membersCount
    }
    
    func setInsuranceAmount(insuranceAmount: String) {
        self.insuranceAmount.text = insuranceAmount
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmount.text = totalAmount
    }
    
    func setSport(sport: String) {
        self.sport.text = sport
    }
    
    func setLoading(isLoading: Bool) {
        confirmButton.isLoading = isLoading
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.sportsPresenter?.applyInsuranceClicked()
    }
}
