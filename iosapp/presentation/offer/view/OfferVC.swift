//
//  Registration4VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OfferVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var gradient: UIView!
    
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var check: UIButton!
    @IBOutlet weak var offerText: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    private lazy var offerPresenter: OfferPresenter = self.presenter as! OfferPresenter
    
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()        
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.0).cgColor,
            UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        ]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        layer.locations = [0.0, 1.0]
        layer.frame = gradient.bounds;
        gradient.layer.insertSublayer(layer, at: 0)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.backButton.isHidden = true
        self.loadingView.layer.opacity = 0.0
        self.offerPresenter.fetchOffer()
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "offer_text".localized(), attributes: underlineAttribute)
        self.offerText.attributedText = underlineAttributedString
        self.nextButton.setTitle("next".localized(), for: .normal)
        self.nextButton.isEnabled = false
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.bottomView.bounds

        self.bottomView.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func checkboxAction(_ sender: Any) {
        self.check.isSelected = !self.check.isSelected
        self.nextButton.isEnabled = self.check.isSelected
    }
    
    
    func setOfferText(text: String) {
        self.text.text = text
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        self.offerPresenter.goNext()
    }
    
    func setLoading(isLoading: Bool) {
//        self.nextButton.isLoading = isLoading
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
    }
    
    
    
}
