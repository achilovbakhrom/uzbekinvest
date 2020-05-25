//
//  AccidentVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class AccidentVC: BaseWithLeftCirclesVC {
    
    private lazy var accidentPresenter = self.presenter as? AccidentPresenter
    
    var product: Product!
    
    
    @IBOutlet weak var accidentTitle: UILabel!
    @IBOutlet weak var accidentDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.accidentPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        accidentTitle.text = product.translates?[0]?.name
        accidentDescription.attributedText
            = product.translates?[0]?.text?.htmlToAttributedString
        self.accidentPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.accidentPresenter?.openAccident1VC()
    }
    
}
