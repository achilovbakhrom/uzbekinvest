//
//  SportVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class SportVC: BaseWithLeftCirclesVC {
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    @IBOutlet weak var sportTitle: UILabel!
    @IBOutlet weak var sportDescription: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.sportsPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.setTabBarHidden(true)
        sportTitle.text = self.product?.translates?[0]?.name
        sportDescription.attributedText = self.product?.translates?[0]?.text?.htmlToAttributedString
        self.sportsPresenter?.setProduct(product: product)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.sportsPresenter?.openSport1VC()
    }
    
}
