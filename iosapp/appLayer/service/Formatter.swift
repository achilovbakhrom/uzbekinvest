//
//  Formatter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/30/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

class Formatter {
    func decimalFormat(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(for: number) ?? ""
    }
}
