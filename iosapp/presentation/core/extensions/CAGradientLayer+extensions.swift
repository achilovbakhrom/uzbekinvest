//
//  CAGradientLayer+extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func makeHorizontalGradinet(leftColor: UIColor, rightColor: UIColor) {
        self.colors = [leftColor.cgColor, rightColor.cgColor]
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        self.locations = [0.0, 1.0]
    }
    
    func makeDiagonalGradient(topLeftColor: UIColor, rightBottomColor: UIColor) {
        self.colors = [topLeftColor.cgColor, rightBottomColor.cgColor]
        self.startPoint = CGPoint(x: -0.1, y: -0.1)
        self.endPoint = CGPoint(x: 1.1, y: 1.1)
        self.locations = [0.0, 1.0]
    }
    
    func makeGreenGradient() {
        let leftColor = UIColor(red: 65.0 / 255.0, green: 228.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        let rightColor
            = UIColor(red: 53.0 / 255.0, green: 197.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
        self.colors = [leftColor.cgColor, rightColor.cgColor]
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        self.locations = [0.0, 1.0]        
    }
    
    func makeGray() {
        let leftColor = UIColor.init(red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 0.65)
        let rightColor
            = UIColor.init(red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 0.65)
        self.colors = [leftColor.cgColor, rightColor.cgColor]
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        self.locations = [0.0, 1.0]
    }
    
    func makeOrangeGrandient() {
        let leftColor = UIColor(red: 255.0 / 255.0, green: 203.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0)
        let rightColor
            = UIColor(red: 255.0 / 255.0, green: 150.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
        self.colors = [leftColor.cgColor, rightColor.cgColor]
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        self.locations = [0.0, 1.0]
    }
    
    func makeGrayBg() {
        let leftColor = UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        let rightColor
            = UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        self.colors = [leftColor.cgColor, rightColor.cgColor]
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        self.locations = [0.0, 1.0]
    }
    
}
