//
//  HomeVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: BaseWithLeftCirclesVC {
    
    private lazy var homePresenter = self.presenter as? HomePresenter

    var product: Product!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.homePresenter?.goBack()
        }
        productTitle.text = product?.translates?[0]?.name
        productDescription.attributedText = product?.translates?[0]?.text?.htmlToAttributedString
        self.homePresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.homePresenter?.openHome1VC()
    }
}
