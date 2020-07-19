//
//  Travel5VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class Travel5VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var individualButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var dobPicker: DatePicker!
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var travelDesc: UILabel!
    @IBOutlet weak var goalType: UILabel!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dobPicker.onChange = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.travelPresenter?.setDob(at: 0, dob: formatter.string(from: $0))
        }
        backButtonClicked = { self.travelPresenter?.goBack() }
        self.selectIndividual()
        nextButton.isEnabled = false
        
        self.nextButton.setTitle("next".localized(), for: .normal)
        self.goalType.text = "tourist_count".localized()
        
        self.individualButton.setTitle("tourist_count_single".localized(), for: .normal)
        
        self.familyButton.setTitle("tourist_count_family".localized(), for: .normal)
        
        self.groupButton.setTitle("tourist_count_group".localized(), for: .normal)
    }
    
    private func selectIndividual() {
        individualButton.active()
        familyButton.inactive()
        groupButton.inactive()
        dobPicker.isHidden = false
        self.travelPresenter?.setType(type: 0, typeString: individualButton.titleLabel?.text ?? "")
                
    }
    
    private func selectFamily() {
        individualButton.inactive()
        familyButton.active()
        groupButton.inactive()
        dobPicker.isHidden = true
        self.travelPresenter?.setType(type: 1, typeString: familyButton.titleLabel?.text ?? "")
    }
    
    private func selectGroup() {
        individualButton.inactive()
        familyButton.inactive()
        groupButton.active()
        dobPicker.isHidden = true
        self.travelPresenter?.setType(type: 1, typeString: groupButton.titleLabel?.text ?? "")
    }
    
    @IBAction func individualButtonAction(_ sender: Any) {
        self.selectIndividual()
    }
    @IBAction func familyButtonActioin(_ sender: Any) {
        self.selectFamily()
    }
    @IBAction func groupButtonAction(_ sender: Any) {
        self.selectGroup()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.travel5ButtonClicked()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}
