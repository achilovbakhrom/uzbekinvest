//
//  InfectionConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class InfectionConfirmVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var insuranceAmountt: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    @IBOutlet weak var confirmButton: Button!
    private lazy var infectionPresenter = self.presenter as? InfectionPresenter
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {}
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.infectionPresenter?.openInfectionFinalVC()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmount.text = totalAmount
    }
    
    func setInsuranceAmount(insuranceAmount: String) {
        self.insuranceAmountt.text = insuranceAmount
    }
    
    func setMembersCount(membersCount: String) {
        self.membersCount.text = membersCount
    }
    
}
