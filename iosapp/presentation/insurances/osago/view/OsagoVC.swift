//
//  OsagoVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class OsagoVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var insuranceTitleLabel: UILabel!
    @IBOutlet weak var insuranceContentLabel: UILabel!
    private lazy var osagoPresenter = self.presenter as? OsagoPresenter
    
    @IBOutlet weak var nextButton: Button!
    var product: Product? = nil
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.osagoPresenter?.goBack() }
        self.setTabBarHidden(true)
        insuranceTitleLabel.text = product?.translates?[translatePosition]?.name
        insuranceContentLabel.textAlignment = .justified
        insuranceContentLabel.text = product?.translates?[translatePosition]?.text?.htmlToString
        self.view.bringSubviewToFront(nextButton)
        self.osagoPresenter?.setProduct(product: product!)
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
        self.osagoPresenter?.openOsago1()
    }
    
    
}
