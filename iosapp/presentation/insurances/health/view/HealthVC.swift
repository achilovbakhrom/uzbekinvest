//
//  HealthVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class HealthVC: BaseWithLeftCirclesVC {
    
    private lazy var healthPresenter = self.presenter as? HealthPresenter
    
    var product: Product!
    
    @IBOutlet weak var healthTitle: UILabel!
    @IBOutlet weak var healthDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.healthPresenter?.goBack()
        }
        healthTitle.text = product?.translates?[translatePosition]?.name
        healthDescription.attributedText = product?.translates?[translatePosition]?.text?.htmlToAttributedString
        healthPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.healthPresenter?.openHealth1VC()
    }
    
}
