//
//  EditProfileView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    
    @IBOutlet weak var nameLabel: SimpleTextField!
    @IBOutlet weak var dobPicker: DatePicker!
    @IBOutlet weak var regionDropDown: DDown!
    @IBOutlet weak var addressTextField: SimpleTextField!
    @IBOutlet weak var changeButton: Button!
    
    var onBack: (() -> Void)? = nil
    var onChange: (() -> Void)? = nil
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.onBack?()
    }
    
    @IBAction func changeAction(_ sender: Any) {
        self.onChange?()
    }
}
