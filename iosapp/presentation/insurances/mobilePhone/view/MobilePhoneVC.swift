//
//  MobilePhoneVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MobilePhoneVC: BaseWithLeftCirclesVC {
    
    private lazy var mobilePhonePresenter = self.presenter as? MobilePhonePresenter
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.mobilePhonePresenter?.goBack() }
        self.titleLabel.text = product?.translates?[translatePosition]?.name
        self.descriptionLabel.attributedText = product?.translates?[translatePosition]?.text?.htmlToAttributedString
        
        self.mobilePhonePresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
        
    }    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.mobilePhonePresenter?.openMobilePhone1VC()
    }
    
}
