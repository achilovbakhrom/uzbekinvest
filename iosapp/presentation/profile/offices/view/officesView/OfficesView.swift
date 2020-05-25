//
//  OfficesView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class OfficesView: UIView {
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backButton: UIImageView!
    var onBackClicked: (() -> Void)? = nil
    
    var onModeChanged: ((Bool) -> Void)? = nil
    private var isListMode = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backButton.isUserInteractionEnabled = true
        self.backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackButtonClicked(gesture:))))
        
        self.listButton.layer.borderWidth = 1.0
        self.listButton.layer.cornerRadius = self.listButton.bounds.height/2
        self.listButton.layer.masksToBounds = true
        self.listButton.addTarget(self, action: #selector(onListButtonClicked(_:)), for: .touchUpInside)
        
        self.mapButton.layer.borderWidth = 1.0
        self.mapButton.layer.cornerRadius = self.listButton.bounds.height/2
        self.mapButton.layer.masksToBounds = true
        self.mapButton.addTarget(self, action: #selector(onMapButtonClicked), for: .touchUpInside)
        
        self.listButton.layer.borderColor = Colors.primaryGreen.cgColor
        self.listButton.setTitleColor(Colors.primaryGreen, for: .normal)
        self.mapButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        self.mapButton.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
    }
    
    func setMode(isListMode: Bool) {
        if self.isListMode != isListMode {
            if isListMode {
                UIView.animate(withDuration: 0.3) {
                    self.listButton.layer.borderColor = Colors.primaryGreen.cgColor
                    self.listButton.setTitleColor(Colors.primaryGreen, for: .normal)
                    self.mapButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
                    self.mapButton.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.mapButton.layer.borderColor = Colors.primaryGreen.cgColor
                    self.mapButton.setTitleColor(Colors.primaryGreen, for: .normal)
                    self.listButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
                    self.listButton.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
                }
            }
            self.isListMode = isListMode
        }
    }
    
    @objc
    private func onMapButtonClicked(_ sender: Any) {
        setMode(isListMode: false)
        onModeChanged?(false)
    }
    
    @objc
    private func onListButtonClicked(_ sender: Any) {
        setMode(isListMode: true)
        onModeChanged?(true)
    }
    
    @objc
    private func onBackButtonClicked(gesture: UITapGestureRecognizer) {
        self.onBackClicked?()
    }
    
}
