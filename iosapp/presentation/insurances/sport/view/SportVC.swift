//
//  SportVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class SportVC: BaseWithLeftCirclesVC {
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    @IBOutlet weak var sportTitle: UILabel!
    @IBOutlet weak var sportDescription: UILabel!
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.sportsPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.setTabBarHidden(true)
        sportTitle.text = self.product?.translates?[0]?.name
        sportDescription.text = self.product?.translates?[0]?.text?.htmlToString
        sportDescription.textAlignment = .justified
        self.sportsPresenter?.setProduct(product: product)
        self.setupNoInternetView()
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            break
        }
    }
    
    func setupNoInternetView() {
        self.view.addSubview(self.noInternetView)
        self.noInternetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noInternetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.noInternetView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noInternetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.noInternetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.view.bringSubviewToFront(self.noInternetView)
        self.noInternetView.layer.opacity = 0.0
        self.noInternetView.onRepeatClicked = {
            self.showNoInternetView(show: false)
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
                break
            case .online(.wwan), .online(.wiFi):
                break
            }
        }
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.sportsPresenter?.openSport1VC()
    }
    
}
