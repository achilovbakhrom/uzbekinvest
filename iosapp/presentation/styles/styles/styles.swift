//
//  styles.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    var gb: CAGradientLayer!
    var gr: CAGradientLayer!
    var db: CAGradientLayer!
    
    var bigGreenBG: CAGradientLayer!
    
    init() {
        let gColorLeft = UIColor(red: 74.0 / 255.0, green: 187.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
        let gColorRight = UIColor(red: 39.0 / 255.0, green: 162.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
        self.gb = CAGradientLayer()
        self.gb.makeHorizontalGradinet(leftColor: gColorLeft, rightColor: gColorRight)
        
        let rColorLeft = UIColor(red: 255.0 / 255.0, green: 164.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
        let rColorRight = UIColor(red: 255.0 / 255.0, green: 116.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0)
        self.gr = CAGradientLayer()
        self.gr.makeHorizontalGradinet(leftColor: rColorLeft, rightColor: rColorRight)
        
        
        self.db = CAGradientLayer()
        self.db.makeHorizontalGradinet(leftColor: UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), rightColor: UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0))
        
        self.bigGreenBG = CAGradientLayer()
        self.bigGreenBG.makeDiagonalGradient(topLeftColor: gColorLeft, rightBottomColor: gColorRight)
    }
    
    static let backArrowBgColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.3)
    static let pageIndicatorGray = UIColor.init(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1)
    static let primaryGreen = UIColor.init(red: 39.0/255.0, green: 162.0/255.0, blue: 73.0/255.0, alpha: 1)
    
    

}
