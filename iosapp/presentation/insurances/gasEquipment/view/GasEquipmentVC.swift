//
//  GasEquipment.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class GasEquipmentVC: BaseWithLeftCirclesVC {
    
    
    private lazy var gasEquipmentPresenter = self.presenter as? GasEquipmentPresenter
    
    var product: Product!
    
    @IBOutlet weak var gasEquipmentTitle: UILabel!
    @IBOutlet weak var gasEquipmentDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gasEquipmentTitle.text = product.translates?[translatePosition]?.name
        self.gasEquipmentDescription.attributedText = product.translates?[translatePosition]?.text?.htmlToAttributedString
        backButtonClicked = { self.gasEquipmentPresenter?.goBack() }
        self.gasEquipmentPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.gasEquipmentPresenter?.openGasEquipment1VC()
    }
    
}
