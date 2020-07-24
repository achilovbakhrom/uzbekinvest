//
//  Int+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

extension Int {
    
    func toForeignPeriod() -> String {
        switch self {
        case 0:
            return "15 days"
        case 1:
            return "2 months"
        case 2:
            return "12 months"
        default:
            return ""
        }
    }
    
    func toForeignPeriodTitle() -> String {
        switch self {
        case 0:
            return "for_15_days".localized()
        case 1:
            return "for_2_months".localized()
        case 2:
            return "for_12_months".localized()
        default:
            return ""
        }
    }
}

extension Int {
    func toUzbCitizenPeriod() -> String {
        switch self {
        case 0:
            return "20 days"
        case 1:
            return "6 months"
        case 2:
            return "12 months"
        default:
            return ""
        }
    }
    func toUzbCitizenPeriodTitle() -> String {
        switch self {
        case 0:
            return "for_20_days".localized()
        case 1:
            return "for_6_months".localized()
        case 2:
            return "for_12_months".localized()
        default:
            return ""
        }
    }
}

extension Int {
    func toDecimalFormat() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(for: self) ?? ""
    }
}

extension Double {
    func toDecimalFormat() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(for: self) ?? ""
    }
}
