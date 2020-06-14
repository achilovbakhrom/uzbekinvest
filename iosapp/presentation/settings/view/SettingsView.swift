//
//  SettingsView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: UIView {
    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var languageContainer: UIStackView!
    
    var currentLanguate: String? {
        didSet {
            languageButton.setTitle(currentLanguate, for: .normal)
        }
    }
    
    var onProfileClick: (() -> Void)? = nil
    var onPinflClick: (() -> Void)? = nil
    var onExitClick: (() -> Void)? = nil
    var onLanguageClick: (() -> Void)? = nil
    var onBackClick: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrow.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        languageButton.isUserInteractionEnabled = false
        languageContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLanguageAction(gesture:))))
    }
    
    @objc
    private func onLanguageAction(gesture: UITapGestureRecognizer) {
        onLanguageClick?()
    }
    
    @IBAction func editProfile(_ sender: Any) {
        onProfileClick?()
    }
    
    @IBAction func pinflClicked(_ sender: Any) {
        onPinflClick?()
    }
    
    @IBAction func exitClicked(_ sender: Any) {
        onExitClick?()
    }
    
    @IBAction func backAction(_ sender: Any) {
        onBackClick?()
    }
    
}
