//
//  OsagoVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OsagoVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var insuranceTitleLabel: UILabel!
    @IBOutlet weak var insuranceContentLabel: UILabel!
    private lazy var osagoPresenter = self.presenter as? OsagoPresenter
    
    @IBOutlet weak var nextButton: Button!
    var product: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.osagoPresenter?.goBack() }
        self.setTabBarHidden(true)
        insuranceTitleLabel.text = product?.translates?[0]?.name
        insuranceContentLabel.attributedText = product?.translates?[0]?.text?.htmlToAttributedString
        self.view.bringSubviewToFront(nextButton)
        self.osagoPresenter?.setProduct(product: product!)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.osagoPresenter?.openOsago1()
    }
    
    
}
