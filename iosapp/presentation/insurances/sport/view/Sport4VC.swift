//
//  Sport4VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Sport4VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var yes: UIButton!
    @IBOutlet weak var no: UIButton!
    @IBOutlet weak var period: DDown!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    private lazy var periodData: ([Int], [String]) = {
        var ids: [Int] = [0, 1, 2, 3]
        var array: [String] = ["sport_10".localized(), "sport_15".localized(), "sport_30".localized(), "sport_1_year".localized()]
        
        return (ids, array)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yes.active()
        no.inactive()
        self.period.optionIds = periodData.0
        self.period.optionArray = periodData.1
        self.period.didSelect {
            self.sportsPresenter?.setPeriod(perdiod: $2, periodString: $0)
        }
        self.backButtonClicked = { self.sportsPresenter?.goBack() }
        self.sportsPresenter?.setIsCompetitionPeriod(isCompetitionPeriod: true)
        nextButton.isEnabled = false
    }
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        yes.active()
        no.inactive()
        UIView.animate(withDuration: 0.2) {
            self.period.layer.opacity = 1.0
        }
        self.sportsPresenter?.setIsCompetitionPeriod(isCompetitionPeriod: true)
        
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func noButtonClicked(_ sender: Any) {
        yes.inactive()
        no.active()
        UIView.animate(withDuration: 0.2) {
            self.period.layer.opacity = 0.0
        }
        self.sportsPresenter?.setIsCompetitionPeriod(isCompetitionPeriod: false)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.sportsPresenter?.openSportConfirmVC()
    }
}
