//
//  IncidentAddressVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentAddressVC: UIViewController {
    
    var addressView: AddressView  = AddressView.fromNib()
    
    var onAddressChange: ((String) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(addressView)
        NSLayoutConstraint.activate([
            self.addressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.addressView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.addressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.addressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.addressView.addressTextField.onChange = onAddressChange
    }
}
