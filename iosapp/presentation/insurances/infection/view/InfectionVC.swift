//
//  InfectionVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class InfectionVC: BaseWithLeftCirclesVC {
    
    private lazy var infectionPresenter = self.presenter as? InfectionPresenter
    
    @IBOutlet weak var infectionTitle: UILabel!
    @IBOutlet weak var infectionDescription: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.infectionPresenter?.goBack() }
        self.infectionTitle.text = self.product.translates?[translatePosition]?.name
        self.infectionDescription.attributedText = self.product.translates?[translatePosition]?.text?.htmlToAttributedString
        
        self.infectionPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.infectionPresenter?.openInfection1VC()
    }
    
}
