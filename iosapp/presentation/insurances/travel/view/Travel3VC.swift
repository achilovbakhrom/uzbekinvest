//
//  Travel3VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class Travel3VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var nextButton: Button!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    @IBOutlet weak var singleButton: UIButton!
    @IBOutlet weak var multipleButton: UIButton!
    @IBOutlet weak var startDate: DatePicker!
    @IBOutlet weak var endDate: DatePicker!
    @IBOutlet weak var multiDropDown: DDown!
    
    
    @IBOutlet weak var travelTitle: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    private lazy var multiData: ([Int], [String]) = {
        return (
            [ 0, 1, 2, 3, 4 ],
            [
                "travel_multiple_type0_text".localized(),
                "travel_multiple_type1_text".localized(),
                "travel_multiple_type2_text".localized(),
                "travel_multiple_type3_text".localized(),
                "travel_multiple_type4_text".localized()
            ]
        )
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.nextButton.setTitle("next".localized(), for: .normal)
        self.travelTitle.text = "travel1_title".localized()
        self.typeLabel.text = "travel3_type".localized()
        
        singleButton.setTitle("travel3_single".localized(), for: .normal)
        multipleButton.setTitle("travel3_multiple".localized(), for: .normal)
        multiDropDown.placeholder = "multi_type".localized()
        multiDropDown.font = UIFont.init(name: "Roboto-Regular", size: 13.0)
        nextButton.setTitle("next".localized(), for: .normal)
        
        backButtonClicked = { self.travelPresenter?.goBack() }
        startDate.floatText = "start_period".localized()
        startDate.onChange = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.travelPresenter?.setTravelStartDate(startDate: formatter.string(from: $0))
        }
        endDate.floatText = "end_period".localized()
        endDate.onChange = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.travelPresenter?.setTravelEndDate(endDate: formatter.string(from: $0))
        }
        multiDropDown.optionIds = multiData.0
        multiDropDown.optionArray = multiData.1
        nextButton.isEnabled = false
        self.selectSingle()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravel4VC()
    }
    
    private func selectSingle() {
        self.singleButton.active()
        self.multipleButton.inactive()
        self.startDate.isHidden = false
        self.endDate.isHidden = false
        self.multiDropDown.isHidden = true
        self.travelPresenter?.setMultiType(type: 0)
    }
    
    private func selectMultiple() {
        self.singleButton.inactive()
        self.multipleButton.active()
        self.startDate.isHidden = true
        self.endDate.isHidden = true
        self.multiDropDown.isHidden = false
        self.travelPresenter?.setMultiType(type: 1)
    }
    
    @IBAction func singleButtonAction(_ sender: Any) {
        self.selectSingle()
    }
    
    @IBAction func multipleButtonAction(_ sender: Any) {
        self.selectMultiple()
    }
    
}
