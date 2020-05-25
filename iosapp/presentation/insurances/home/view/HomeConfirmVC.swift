//
//  HomeConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class HomeConfirmVC: BaseWithRightGreenCirclesVC {

    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var confirmButton: Button!
    
    private lazy var homePresenter = self.presenter as? HomePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homePresenter?.fillConfirmData()
        self.homePresenter?.calculateHome()
        backButtonClicked = { self.homePresenter?.goBack() }
        
        
    }
    
    func setTotalAmount(amount: String) {
        self.totalAmount.text = amount
    }
    
    func setType(type: String) {
        self.type.text = type
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.homePresenter?.applyInsuranceClicked()
    }
    
    func setLoading(isLoading: Bool) {
        self.confirmButton.isLoading = isLoading
    }
    
}
