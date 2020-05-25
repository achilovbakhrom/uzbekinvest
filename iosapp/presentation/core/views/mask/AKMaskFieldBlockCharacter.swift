//
//  AKMaskFieldBlockCharacter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

/// A structure that contains the block character main properties.
public struct AKMaskFieldBlockCharacter {
    
    //  MARK: - General    
    /// Character index in the block.
    
    public var index: Int
    
    /// The block index in the mask.
    
    public var blockIndex: Int
    
    /// Current character status.
    
    public var status: AKMaskFieldStatus
    
    //  MARK: - Pattern
    
    /// The mask pattern character.
    
    public var pattern: AKMaskFieldPatternCharacter!
    
    /// Location of the pattern character in the mask.
    
    public var patternRange: NSRange
    
    //  MARK: - Mask template
    
    /// The mask template character.
    
    public var template: Character!
    
    /// Location of the mask template character in the mask template.
    
    public var templateRange: NSRange
}
