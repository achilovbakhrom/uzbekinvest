//
//  LuggageVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class LuggageVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var product: Product!
    
    private lazy var luggagePresenter = self.presenter as? LuggagePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButtonClicked = { self.luggagePresenter?.goBack() }
        self.titleLabel.text = self.product.translates?[translatePosition]?.name
        self.descriptionLabel.attributedText = self.product.translates?[translatePosition]?.text?.htmlToAttributedString
        self.luggagePresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.luggagePresenter?.openLuggage1VC()
    }
    
}
