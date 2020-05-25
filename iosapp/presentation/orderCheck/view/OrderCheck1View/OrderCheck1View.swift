//
//  OrderCheck1View.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OrderCheck1View: UIView {
    
    @IBOutlet weak var orderList: SimpleTextField!
    @IBOutlet weak var polisNumber: SimpleTextField!
    @IBOutlet weak var checkButton: Button!
    
    var onCheckClicked: (() -> Void)? = nil
    
    @IBAction func onCheckButtonClicked(_ sender: Any) {
        self.onCheckClicked?()
        
    }
    
}
