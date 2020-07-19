//
//  Travel4VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class Travel4VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var sportButton: UIButton!
    @IBOutlet weak var travel4Desc: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.travelPresenter?.goBack() }
        self.selectTravel()
        
        travel4Desc.text = "travel1_title".localized()
        goalType.text = "goal_type".localized()
        
        travelButton.setTitle("travel_type".localized(), for: .normal)
        workButton.setTitle("work_type".localized(), for: .normal)
        sportButton.setTitle("sport_type".localized(), for: .normal)
        
        nextButton.setTitle("next".localized(), for: .normal)
    }
    
    private func selectTravel() {
        travelButton.active()
        workButton.inactive()
        sportButton.inactive()
        self.travelPresenter?.setPurpose(purpose: 0, purposeString: travelButton.titleLabel?.text ?? "")
    }
    
    private func selectWork() {
        travelButton.inactive()
        workButton.active()
        sportButton.inactive()
        self.travelPresenter?.setPurpose(purpose: 1, purposeString: workButton.titleLabel?.text ?? "")
    }
    
    private func selectSport() {
        travelButton.inactive()
        workButton.inactive()
        sportButton.active()
        self.travelPresenter?.setPurpose(purpose: 2, purposeString: sportButton.titleLabel?.text ?? "")
    }
    
    @IBAction func travelButtonAction(_ sender: Any) {
        self.selectTravel()
    }
    
    @IBAction func workButtonAction(_ sender: Any) {
        self.selectWork()
    }
    
    @IBAction func sportButtonAction(_ sender: Any) {
        self.selectSport()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.travel4VCNextButtonClicked()
    }
    
}

