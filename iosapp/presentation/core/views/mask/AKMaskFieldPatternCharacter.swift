//
//  AKMaskFieldPatternCharacter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

public enum AKMaskFieldPatternCharacter: String {
    
    //  MARK: - Constants
    
    case NumberDecimal = "d"
    case NonDecimal    = "D"
    case NonWord       = "W"
    case Alphabet      = "a"
    case AnyChar       = "."
    
    /// Returns regular expression pattern.
    
    public func pattern() -> String {
        switch self {
        case .NumberDecimal   : return "\\d"
        case .NonDecimal      : return "\\D"
        case .NonWord         : return "\\W"
        case .Alphabet        : return "[a-zA-Z]"
        default               : return "."
        }
    }
}
