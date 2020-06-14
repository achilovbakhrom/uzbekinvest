//
//  MainProfileView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MainProfileView: UIView {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var withUsView: UIView!
    @IBOutlet weak var withUsLabel: UILabel!
    @IBOutlet weak var myPolicesView: UIView!
    @IBOutlet weak var myPolicesLabel: UILabel!
    @IBOutlet weak var incidentsView: UIView!
    @IBOutlet weak var incidentsLabel: UILabel!
    @IBOutlet weak var myDocsImage: UIImageView!
    @IBOutlet weak var myDocsLabel: UILabel!
    @IBOutlet weak var branchesImage: UIImageView!
    @IBOutlet weak var branchesLabel: UILabel!
    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var faqImageView: UIImageView!
    @IBOutlet weak var faqLabel: UILabel!
    @IBOutlet weak var aboutImageView: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    
    var onMyDocs: (() -> Void)? = nil
    var onBranchesList: (() -> Void)? = nil
    var onSettings: (() -> Void)? = nil
    var onFaq: (() -> Void)? = nil
    var onAbout: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        myDocsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMyDocsClicked(gesture:))))
        myDocsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMyDocsClicked(gesture:))))
        
        branchesImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBranchesClicked(gesture:))))
        branchesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBranchesClicked(gesture:))))
        
        settingsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSettingsClicked(gesture:))))
        settingsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSettingsClicked(gesture:))))
        
        let radius = UIScreen.main.bounds.width * 0.17/2.0
        
        withUsView.layer.cornerRadius = radius
        withUsView.layer.borderWidth = 2.0
        withUsView.layer.borderColor = Colors.primaryGreen.cgColor
        
        myPolicesView.layer.cornerRadius = radius
        myPolicesView.layer.borderWidth = 2.0
        myPolicesView.layer.borderColor = UIColor.init(red: 77.0/255.0, green: 207.0/255.0, blue: 224.0/255.0, alpha: 1.0).cgColor
        
        incidentsView.layer.cornerRadius = radius
        incidentsView.layer.borderWidth = 2.0
        incidentsView.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 197.0/255.0, blue: 47.0/255.0, alpha: 1.0).cgColor
        
        self.faqImageView.isUserInteractionEnabled = true
        self.faqImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFaqAction(gesture:))))
        
        self.faqLabel.isUserInteractionEnabled = true
        self.faqLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFaqAction(gesture:))))
        self.faqLabel.text = "faq".localized()
        
        self.aboutImageView.isUserInteractionEnabled = true
        self.aboutImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAboutAction(gesture:))))
        
        self.aboutLabel.isUserInteractionEnabled = true
        self.aboutLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAboutAction(gesture:))))
        self.aboutLabel.text = "about_us".localized();
    }
    
    
    @objc
    private func onMyDocsClicked(gesture: UITapGestureRecognizer) {
        self.onMyDocs?()
    }
    
    @objc
    private func onBranchesClicked(gesture: UITapGestureRecognizer) {
        self.onBranchesList?()
    }
    
    @objc
    private func onSettingsClicked(gesture: UITapGestureRecognizer) {
        self.onSettings?()
    }
    
    @objc
    private func onFaqAction(gesture: UITapGestureRecognizer) {
        self.onFaq?()
    }
    
    @objc
    private func onAboutAction(gesture: UITapGestureRecognizer) {
        self.onAbout?()
    }
    
}

