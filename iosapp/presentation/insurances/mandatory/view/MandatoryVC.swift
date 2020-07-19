//
//  MandatoryVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MandatoryVC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var nextButton: Button!
    
    
    @IBOutlet weak var mandatoryTitle: UILabel!
    @IBOutlet weak var mandatoryDescription: UILabel!
    
    var product: Product!
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = {
            self.mandatoryPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.mandatoryTitle.text = product?.translates?[translatePosition]?.name
        self.mandatoryDescription.textAlignment = .justified
        self.mandatoryDescription.text = product?.translates?[translatePosition]?.text?.htmlToString
        
        self.mandatoryPresenter?.setProduct(product: product)
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
        self.mandatoryPresenter?.openMandatory1()
    }
    
}
