//
//  LocationPickerViewController+Extension.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import LocationPicker

fileprivate var storedProperty_FILEPRIVATE: (() -> Void)? = nil

extension LocationPickerViewController {
    
    var onClose: (() -> Void)? {
        get { return storedProperty_FILEPRIVATE ?? nil }
        set { storedProperty_FILEPRIVATE = newValue }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onClose?()
        
    }
    
}
