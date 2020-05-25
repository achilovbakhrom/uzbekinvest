//
//  KaskoVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class KaskoVC: BaseWithLeftCirclesVC {
    
    private lazy var kaskoPresenter = self.presenter as? KaskoPresenter
    
    var product: Product!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = product?.translates?[0]?.name
        self.descriptionLabel.attributedText = product.translates?[0]?.text?.htmlToAttributedString
        backButtonClicked = {
            self.kaskoPresenter?.goBack()
        }
        self.setTabBarHidden(true)
        self.kaskoPresenter?.setProduct(product: product)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.kaskoPresenter?.openKasko1()
    }
    
}
