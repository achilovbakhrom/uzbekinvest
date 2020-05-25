//
//  Kasko1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Kasko1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var standart: UIButton!
    @IBOutlet weak var premium: UIButton!
    @IBOutlet weak var gold: UIButton!
    @IBOutlet weak var kasko2: UIButton!
    
    
    @IBOutlet weak var nextButton: Button!
    
    private lazy var kaskoPresenter = self.presenter as? KaskoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.kaskoPresenter?.goBack()
            self.kaskoPresenter?.setType(type: 0, typeString: self.standart.titleLabel?.text ?? "")
        }
        self.standart.active()
        self.premium.inactive()
        self.gold.inactive()
        self.kasko2.inactive()
        self.kaskoPresenter?.setType(type: 0, typeString: standart.titleLabel?.text ?? "")
    }
    
    @IBAction func standartClicked(_ sender: Any) {
        self.standart.active()
        self.premium.inactive()
        self.gold.inactive()
        self.kasko2.inactive()
        self.kaskoPresenter?.setType(type: 0, typeString: standart.titleLabel?.text ?? "")
    }
    
    @IBAction func premiumClicked(_ sender: Any) {
        self.standart.inactive()
        self.premium.active()
        self.gold.inactive()
        self.kasko2.inactive()
        self.kaskoPresenter?.setType(type: 1, typeString: premium.titleLabel?.text ?? "")

    }
    
    @IBAction func goldClicked(_ sender: Any) {
        self.standart.inactive()
        self.premium.inactive()
        self.gold.active()
        self.kasko2.inactive()
        self.kaskoPresenter?.setType(type: 2, typeString: gold.titleLabel?.text ?? "")
    }
    
    @IBAction func kasko2Clicked(_ sender: Any) {
        self.standart.inactive()
        self.premium.inactive()
        self.gold.inactive()
        self.kasko2.active()
        self.kaskoPresenter?.setType(type: 3, typeString: gold.titleLabel?.text ?? "")
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.kaskoPresenter?.openKasko2()
    }
    
}
