//
//  RoadTechSupportVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class RoadTechSupportVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var nextButton: Button!
    private lazy var roadTechPresenter = self.presenter as? RoadTechPresenter
    var product: Product!
    
    @IBOutlet weak var techRoadTitle: UILabel!
    @IBOutlet weak var techRoadDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.roadTechPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.setTabBarHidden(true)
        self.roadTechPresenter?.setProduct(product: product)
        techRoadTitle.text = product.translates?[translatePosition]?.name
        techRoadDescription.attributedText = product.translates?[translatePosition]?.text?.htmlToAttributedString
        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.roadTechPresenter?.openTechRoad1VC()
    }
    
}
