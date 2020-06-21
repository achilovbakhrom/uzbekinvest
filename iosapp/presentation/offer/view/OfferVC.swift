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
        self.offerPresenter.fetchOffer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.loadingView.layer.opacity = 0.0
    }
    
    @IBAction func accept(_ sender: Any) {
//        self.registrationPresenter.acceptOffer()
        
    }
    
    func setLoading(isLoading: Bool) {
        self.nextButton.isLoading = isLoading
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
