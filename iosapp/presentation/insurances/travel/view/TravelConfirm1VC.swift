//
//  TravelConfirm1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class TravelConfirm1VC: BaseWithRightGreenCirclesVC {
    
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var tariff: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var purpose: UILabel!
    @IBOutlet weak var groupType: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var tarifLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var touristCountLabel: UILabel!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.travelPresenter?.goBack() }
        
        
        self.titleLabel.text = "travel1_title".localized();
        self.countryLabel.text = "tourist_country_confirm".localized();
        self.amountLabel.text = "amount_of_covered_cost".localized()
        self.tariff.text = "program".localized()
        self.typeLabel.text = "travel3_type".localized()
        self.goalLabel.text = "goal_type".localized()
        self.touristCountLabel.text = "tourist_count".localized()
        
        self.confirmButton.setTitle("checkout".localized(), for: .normal)
        
        self.travelPresenter?.fillConfirm1VC()
        self.travelPresenter?.calculate()
    }
    
    func setTotalAmount(amount: String) {
        self.insuranceAmount.text = amount
    }
    
    func setCountry(country: String) {
        self.country.text = country
    }
    
    func setAmount(amount: String) {
        self.amount.text = amount
    }
    
    func setTariff(tariff: String) {
        self.tariff.text = tariff
    }
    
    func setType(type: String) {
        self.type.text = type
    }
    
    func setPurpose(purpose: String) {
        self.purpose.text = purpose
    }
    
    func setGroupType(type: String) {
        self.groupType.text = type
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravelConfirm2VC()
    }
    
}
