//
//  EmptyView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    var onAdd: (() -> Void)? = nil
    var onBuy: (() -> Void)? = nil
    
    @IBAction func addButtonClicked(_ sender: Any) {
        onAdd?()
    }
    
    
    @IBAction func butButtonClicked(_ sender: Any) {
        onBuy?()
    }
    
}
