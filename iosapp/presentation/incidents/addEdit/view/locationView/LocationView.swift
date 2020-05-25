//
//  LocationView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class LocationView: UIView {
    
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var byMapButton: UIButton!
    @IBOutlet weak var byAddressButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextButton: Button!
    var onBackClicked: (() -> Void)? = nil
    var onNext: (() -> Void)? = nil
    var onModeChanged: ((Bool) -> Void)? = nil
    private var isMapMode = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backButton.isUserInteractionEnabled = true
        self.backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackButtonClicked(gesture:))))

        self.byMapButton.layer.borderWidth = 1.0
        self.byMapButton.layer.cornerRadius = self.byMapButton.bounds.height/2
        self.byMapButton.layer.masksToBounds = true
        self.byMapButton.addTarget(self, action: #selector(onListButtonClicked(_:)), for: .touchUpInside)
        
        self.byAddressButton.layer.borderWidth = 1.0
        self.byAddressButton.layer.cornerRadius = self.byAddressButton.bounds.height/2
        self.byAddressButton.layer.masksToBounds = true
        self.byAddressButton.addTarget(self, action: #selector(onMapButtonClicked), for: .touchUpInside)
        
        self.byMapButton.layer.borderColor = Colors.primaryGreen.cgColor
        self.byMapButton.setTitleColor(Colors.primaryGreen, for: .normal)
        self.byAddressButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        self.byAddressButton.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
    }
    
    
    func setMode(isMapMode: Bool) {
        if self.isMapMode != isMapMode {
            if isMapMode {
                UIView.animate(withDuration: 0.3) {
                    self.byMapButton.layer.borderColor = Colors.primaryGreen.cgColor
                    self.byMapButton.setTitleColor(Colors.primaryGreen, for: .normal)
                    self.byAddressButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
                    self.byAddressButton.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.byAddressButton.layer.borderColor = Colors.primaryGreen.cgColor
                    self.byAddressButton.setTitleColor(Colors.primaryGreen, for: .normal)
                    self.byMapButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
                    self.byMapButton.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
                }
            }
            self.isMapMode = isMapMode
        }
    }
    
    @objc
    private func onMapButtonClicked(_ sender: Any) {
        setMode(isMapMode: false)
        onModeChanged?(false)
    }
    
    @objc
    private func onListButtonClicked(_ sender: Any) {
        setMode(isMapMode: true)
        onModeChanged?(true)
    }
    
    @objc
    private func onBackButtonClicked(gesture: UITapGestureRecognizer) {
        self.onBackClicked?()
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.onNext?()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
}

