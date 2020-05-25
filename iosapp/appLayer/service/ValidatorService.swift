//
//  ValidatorService.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol ValidatorProtocol {
    func validatePhone(phoneNumber: String) -> Bool
}


class Validator: ValidatorProtocol {
    
    func validatePhone(phoneNumber: String) -> Bool {
        return phoneNumber.count == 12 && phoneNumber.starts(with: "9989")        
    }
    
}
