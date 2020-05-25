//
//  OrderCheck2View.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/25/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class OrderCheck2View: UIView {
    
    @IBOutlet weak var insuranceName: UILabel!
    @IBOutlet weak var paymentStatus: UILabel!
    @IBOutlet weak var polisAmount: UILabel!
    @IBOutlet weak var leftDays: UILabel!
    @IBOutlet weak var insuranceAmount: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    
    var onBack: (() -> Void)? = nil
    var onToMainPage: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusContainer.layer.cornerRadius = self.statusContainer.bounds.height/2
        self.statusContainer.layer.masksToBounds = true
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        onBack?()        
    }
    
    @IBAction func toMainPageClicked(_ sender: Any) {
        onToMainPage?()
    }
    
}
