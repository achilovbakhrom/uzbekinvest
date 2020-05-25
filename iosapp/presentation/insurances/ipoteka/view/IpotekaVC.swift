//
//  IpotekaVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class IpotekaVC: BaseWithLeftCirclesVC {
    
    private lazy var ipotekaPresenter = self.presenter as? IpotekaPresenter
    @IBOutlet weak var ipotekaTitle: UILabel!
    
    @IBOutlet weak var ipotekaDescription: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ipotekaTitle.text = product.translates?[0]?.name
        ipotekaDescription.text = product.translates?[0]?.text?.htmlToString        
        backButtonClicked = { self.ipotekaPresenter?.goBack() }
        self.ipotekaPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.ipotekaPresenter?.openIpoteka1VC()
    }
    
}
