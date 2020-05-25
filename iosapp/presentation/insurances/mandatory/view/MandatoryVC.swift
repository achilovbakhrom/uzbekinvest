//
//  MandatoryVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MandatoryVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var nextButton: Button!
    
    
    @IBOutlet weak var mandatoryTitle: UILabel!
    @IBOutlet weak var mandatoryDescription: UILabel!
    
    var product: Product!
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.mandatoryPresenter?.goBack() }
        self.mandatoryTitle.text = product?.translates?[0]?.name
        self.mandatoryDescription.attributedText = product?.translates?[0]?.text?.htmlToAttributedString
        self.mandatoryPresenter?.setProduct(product: product)        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.mandatoryPresenter?.openMandatory1()
    }
    
}
