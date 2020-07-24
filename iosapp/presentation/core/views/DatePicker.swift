//
//  DatePicker.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//
import Foundation
import UIKit

class DatePicker: UITextField {
    
    private var underscoreLayer: CALayer! = nil
    private var floatTextLayer: CATextLayer! = nil
    
    var onChange: ((_ date: Date) -> Void)? = nil
    
    @IBInspectable var floatText: String? = nil {
        didSet {
            floatTextLayer?.string = self.floatText
        }
    }
    
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
        self.textColor = UIColor.init(red: 110.0/255.0, green: 110.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        self.setInputViewDatePicker(target: self, selector: #selector(dateSelected), mode: .date)
        self.rightView = UIImageView(image: UIImage(named: "calendar"))
        self.rightViewMode = .always
    }
    
    @objc
    private func dateSelected() {
        if let datePicker = self.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "dd.MM.yyyy"
            self.text = dateformatter.string(from: datePicker.date)
            if let v = onChange { v(datePicker.date) }
        }
        self.resignFirstResponder()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if underscoreLayer == nil {
            underscoreLayer = CALayer()
            underscoreLayer.backgroundColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.6).cgColor
            underscoreLayer.frame = CGRect(x: 0, y: self.frame.height + 4.0, width: self.frame.width, height: 1.0)
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
    
}


class TimePicker: UITextField {
    
    private var underscoreLayer: CALayer! = nil
    private var floatTextLayer: CATextLayer! = nil
    
    var onChange: ((_ date: Date) -> Void)? = nil
    
    @IBInspectable var floatText: String? = nil {
        didSet {
            floatTextLayer?.string = self.floatText
        }
    }
    
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
        self.textColor = UIColor.init(red: 110.0/255.0, green: 110.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        self.setInputViewDatePicker(target: self, selector: #selector(dateSelected), mode: .time)
        self.rightView = UIImageView(image: UIImage(named: "calendar"))
        self.rightViewMode = .always
    }
    
    @objc
    private func dateSelected() {
        if let datePicker = self.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "HH:mm"
            self.text = dateformatter.string(from: datePicker.date)
            if let v = onChange { v(datePicker.date) }
        }
        self.resignFirstResponder()
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
    
}
