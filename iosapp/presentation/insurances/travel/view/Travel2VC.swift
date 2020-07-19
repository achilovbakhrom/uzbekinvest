//
//  Travel2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Travel2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var twentyFiveThousandButton: UIButton!
    @IBOutlet weak var sixtyThousandButton: UIButton!
    @IBOutlet weak var hundredThousandButton: UIButton!
    
    @IBOutlet weak var standart1: UIButton!
    @IBOutlet weak var standart2: UIButton!
    @IBOutlet weak var standart3: UIButton!
    @IBOutlet weak var travel2desc: UILabel!
    @IBOutlet weak var travel2AmountTitle: UILabel!
    @IBOutlet weak var tariffTitle: UILabel!
    
    @IBOutlet weak var nextButton: Button!
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    private var amount1: Int = 0
    private var amount2: Int = 0
    private var amount3: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.travelPresenter?.goBack() }
        self.travelPresenter?.setupTravel2VC()
        self.select25()
        self.selectStandart1()
        self.travel2desc.text = "travel1_title".localized()
        self.travel2AmountTitle.text = "travel2_amount_title".localized()
        self.tariffTitle.text = "tarif".localized()
        self.nextButton.setTitle("next".localized(), for: .normal)
    }
    
    private func select25() {
        twentyFiveThousandButton.active()
        sixtyThousandButton.inactive()
        hundredThousandButton.inactive()
        self.travelPresenter?.setInsuranceAmount(insuranceAmount: amount1, insuranceAmountString: twentyFiveThousandButton.titleLabel?.text ?? "")
    }
    
    private func select60() {
        twentyFiveThousandButton.inactive()
        sixtyThousandButton.active()
        hundredThousandButton.inactive()
        self.travelPresenter?.setInsuranceAmount(insuranceAmount: amount2, insuranceAmountString: sixtyThousandButton.titleLabel?.text ?? "")
    }
    
    private func select100() {
        twentyFiveThousandButton.inactive()
        sixtyThousandButton.inactive()
        hundredThousandButton.active()
        self.travelPresenter?.setInsuranceAmount(insuranceAmount: amount3, insuranceAmountString: hundredThousandButton.titleLabel?.text ?? "")
    }
    
    private func selectStandart1() {
        self.standart1.active()
        self.standart2.inactive()
        self.standart3.inactive()
        self.travelPresenter?.setPlan(plan: 0, planString: standart1.titleLabel?.text ?? "")
    }
    
    private func selectStandart2() {
        self.standart1.inactive()
        self.standart2.active()
        self.standart3.inactive()
        self.travelPresenter?.setPlan(plan: 1, planString: standart2.titleLabel?.text ?? "")
    }
    
    private func selectStandart3() {
        self.standart1.inactive()
        self.standart2.inactive()
        self.standart3.active()
        self.travelPresenter?.setPlan(plan: 2, planString: standart3.titleLabel?.text ?? "")
    }
    
    
    @IBAction func twentyFiveAction(_ sender: Any) {
        self.select25()
    }
    
    @IBAction func sixtyThousandAction(_ sender: Any) {
        self.select60()
    }
    
    @IBAction func hundredThousandAction(_ sender: Any) {
        self.select100()
    }
    
    @IBAction func standart1Action(_ sender: Any) {
        self.selectStandart1()
    }
    
    @IBAction func standart2Action(_ sender: Any) {
        self.selectStandart2()
    }
    
    @IBAction func standart3Action(_ sender: Any) {
        self.selectStandart3()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravel3VC()
    }
    
    func setZone(isZoneOne: Bool, isShengen: Bool) {
        if isZoneOne {
            self.twentyFiveThousandButton.layer.opacity = 1.0
            self.sixtyThousandButton.layer.opacity = 0.0
            self.hundredThousandButton.layer.opacity = 0.0
            self.amount1 = 15000
            self.amount2 = 0
            self.amount3 = 0
            self.sixtyThousandButton.inactive()
            self.sixtyThousandButton.isEnabled = false
            self.hundredThousandButton.inactive()
            self.hundredThousandButton.isEnabled = false
            self.twentyFiveThousandButton.setTitle("15 000  €", for: .normal)
        } else {
            self.twentyFiveThousandButton.layer.opacity = 1.0
            self.sixtyThousandButton.layer.opacity = 1.0
            self.hundredThousandButton.layer.opacity = 1.0
            self.amount1 = 25000
            self.amount2 = 60000
            self.amount3 = 100000
            self.twentyFiveThousandButton.setTitle("25 000  €", for: .normal)
            self.sixtyThousandButton.setTitle("65 000  €", for: .normal)
            self.hundredThousandButton.setTitle("100 000  €", for: .normal)
        }
        
        if isShengen {
            self.twentyFiveThousandButton.layer.opacity = 1.0
            self.sixtyThousandButton.layer.opacity = 1.0
            self.hundredThousandButton.layer.opacity = 0.0
            self.amount1 = 60000
            self.amount2 = 100000
            self.amount3 = 0
            self.hundredThousandButton.inactive()
            self.hundredThousandButton.isEnabled = false
            self.twentyFiveThousandButton.setTitle("60 000  €", for: .normal)
            self.sixtyThousandButton.setTitle("100 000  €", for: .normal)
            self.hundredThousandButton.setTitle("100 000  €", for: .normal)
        }
        
    }
    
}
