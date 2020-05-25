//
//  NoInternetView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/10/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class NoInternetView: UIView {
    
    @IBOutlet weak var callSupportLabel: UILabel!
    
    var onRepeatClicked: (() -> Void)? = nil
    var onCallSupportClicked: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        callSupportLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callSupportAction(gesture:))))
    }
    
    @IBAction func onRepeat(_ sender: Any) {
        self.onRepeatClicked?()
    }
    
    @IBAction func onCallSupport(_ sender: Any) {
        self.onCallSupportClicked?()
    }
    
    @objc
    private func callSupportAction(gesture: UITapGestureRecognizer) {
        self.onCallSupportClicked?()
    }
    
}
