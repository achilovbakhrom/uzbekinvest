//
//  TravelVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class TravelVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descripttionLabel: UILabel!
    
    var product: Product!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.travelPresenter?.goBack() }
        self.titleLabel.text = self.product.translates?[translatePosition]?.name
        self.descripttionLabel.attributedText = self.product.translates?[translatePosition]?.text?.htmlToAttributedString
        self.travelPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravel1VC()
    }
    
}
