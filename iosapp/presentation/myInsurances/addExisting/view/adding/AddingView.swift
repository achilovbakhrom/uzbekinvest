//
//  AddingView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class AddingView: UIView {
    
    
    
    @IBOutlet weak var pinFlNumber: SimpleTextField!
    @IBOutlet weak var addButton: Button!
    
    var onAdd: (() -> Void)? = nil
    
    @IBAction func onAddClicked(_ sender: Any) {
        self.onAdd?()
    }
}
