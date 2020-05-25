//
//  AddingInstructionView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class AddingInstructionView: UIView {
        
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkLabel: UILabel!
    
    var onCheckedChanged: ((Bool) -> Void)? = nil
    var onNextClieckd: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkLabel.isUserInteractionEnabled = true
        checkLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check)))
    }
    
    @objc
    private func check() {
        checkButton.isSelected = !checkButton.isSelected
        self.onCheckedChanged?(checkButton.isSelected)
    }
    
    @IBAction func onCheckClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.onCheckedChanged?(sender.isSelected)
    }
    
    @IBAction func onNextButtonClicked(_ sender: Any) {
        self.onNextClieckd?()
    }
    
}
