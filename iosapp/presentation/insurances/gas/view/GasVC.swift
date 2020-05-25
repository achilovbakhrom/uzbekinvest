//
//  GasVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class GasVC: BaseWithLeftCirclesVC {
    
    private lazy var gasPresenter = self.presenter as? GasPresenter
    
    var product: Product!
    
    @IBOutlet weak var gasHomeTitle: UILabel!
    @IBOutlet weak var gasHomeDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.gasPresenter?.goBack()
            self.setTabBarHidden(true)
        }
        self.gasPresenter?.setProduct(product: product)
        gasHomeTitle.text = product?.translates?[translatePosition]?.name ?? ""
        gasHomeDescription.attributedText = product?.translates?[0]?.text?.htmlToAttributedString
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasPresenter?.openGas1VC()
    }
}
