//
//  Kasko2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Kasko2VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var period: DDown!
    @IBOutlet weak var carPrice: SimpleTextField!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var kaskoPresenter = self.presenter as? KaskoPresenter
    
    private lazy var periodValues: [Float] = []
    private lazy var titles: [String] = []
    private lazy var ids: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kaskoPresenter?.setup2VC()
        self.period.optionArray = titles
        self.period.optionIds = ids
        self.period.didSelect { (title, index, _) in
            self.kaskoPresenter?.setPeriod(period: self.periodValues[index], periodString: title)
        }
        self.carPrice.onChange = {
            self.kaskoPresenter?.setCarPrice(price: Int($0) ?? 0)
        }
        self.nextButton.isEnabled = false
        self.backButtonClicked = { self.kaskoPresenter?.goBack() }
    }
    
    func setTitles(titles: [String]) {
        self.titles = titles
    }
    
    func setPeriodValues(periodValues: [Float]) {
        self.periodValues = periodValues
    }
    
    func setIds(ids: [Int]) {
        self.ids = ids
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.kaskoPresenter?.openKaskoConfirmVC()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
}
