//
//  RoadTechSupportConfirm.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class RoadTechSupportConfirmVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!    
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var roadTechPresenter = self.presenter as? RoadTechPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.roadTechPresenter?.goBack() }
        self.roadTechPresenter?.fillConfirmData()
        self.roadTechPresenter?.calculateTechnicalSupport()
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.roadTechPresenter?.openTechRoadFinalVC()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
    func setInsuranceAmount(insuranceAmount: String) {
        self.insuranceAmount.text = insuranceAmount
    }
    
    func setTotalAmount(totalAmount: String) {
        self.totalAmount.text = totalAmount
    }
    
}
