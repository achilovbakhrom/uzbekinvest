//
//  UILabel+Extensions.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    func strikeThrough(forAbbr: Bool = false) {
        self.textColor = .red
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
        self.font = UIFont.init(name: "Roboto-Regular", size: forAbbr ? 15 : 25)
    }
    
    func removeStrikeThrough(forAbbr: Bool = false) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        self.attributedText = attributeString
        self.textColor = Colors.primaryGreen
        self.font = UIFont.init(name: "Roboto-Regular", size: forAbbr ? 20 : 40)
    }
    
}
