//
//  SimpleTextField.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/30/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class SimpleTextField: UITextField {
    
    private var underscoreLayer: CALayer! = nil
    private var floatTextLayer: CATextLayer! = nil
    var onChange: ((_ text: String) -> Void)? = nil
    @IBInspectable var floatText: String? = nil {
        didSet {
            floatTextLayer?.string = self.floatText
        }
    }
    
    @IBInspectable var length: Int = 0
    @IBInspectable var isNumber: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.borderStyle = .none
        self.font = UIFont.init(name: "Roboto-Regular", size: 20)
        self.textColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        self.addTarget(self, action: #selector(editing(_:)), for: .editingChanged)
    }
    
    
    @objc
    func editing(_ textField: UITextField) {
        
        var text = textField.text ?? ""
        
        text = text.replacingOccurrences(of: " ", with: "")
        
        if length > 0 && text.count > length {
            text = text.substring(to: length)
        }
        
        var amount = ""
        var showAmount = ""
        
        if isNumber {
            amount = "\(Int(text) ?? 0)"
            showAmount = "\((Int(text) ?? 0).toDecimalFormat())"
        } else {
            amount = text;showAmount = text
        }
        
        if let v = onChange {
            textField.text = showAmount
            v(amount)
        }
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if underscoreLayer == nil {
            underscoreLayer = CALayer()
            underscoreLayer.backgroundColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0).cgColor
            underscoreLayer.frame = CGRect(x: 0, y: self.frame.height + 4.0, width: self.frame.width, height: 2.0)
            self.layer.addSublayer(underscoreLayer)
        }
        
        if floatTextLayer == nil {
            floatTextLayer = CATextLayer()
            floatTextLayer.font = UIFont.init(name: "Roboto-Regular", size: 15)
            floatTextLayer.fontSize = 13
            floatTextLayer.foregroundColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0).cgColor
            floatTextLayer.contentsScale = UIScreen.main.scale
            floatTextLayer.string = self.floatText
            floatTextLayer.frame = CGRect(x: 3, y: -24, width: self.frame.width, height: 20)
            self.layer.addSublayer(floatTextLayer)
        }
    }
    
    
//    override func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            if let u = self.underscoreLayer {
//                u.backgroundColor = Colors.primaryGreen.cgColor
//                self.floatTextLayer?.foregroundColor = Colors.primaryGreen.cgColor
//
//                self.layoutIfNeeded()
//            }
//        }
//
//    }
//
//    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        UIView.animate(withDuration: 0.5) {
//            if let u = self.underscoreLayer {
//                u.backgroundColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0).cgColor
//                self.floatTextLayer?.foregroundColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0).cgColor
//
//                self.layoutIfNeeded()
//            }
//        }
//        return true
//    }
//
//    override func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        UIView.animate(withDuration: 0.5) {
//            if let u = self.underscoreLayer {
//                u.backgroundColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0).cgColor
//                self.floatTextLayer?.foregroundColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0).cgColor
//
//                self.layoutIfNeeded()
//            }
//        }
//        return true
//    }
    
}
