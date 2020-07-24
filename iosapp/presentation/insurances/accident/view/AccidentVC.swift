//
//  AccidentVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class AccidentVC: BaseWithLeftCirclesVC {
    
    private lazy var accidentPresenter = self.presenter as? AccidentPresenter
    
    var product: Product!
    
    
    @IBOutlet weak var accidentTitle: UILabel!
    @IBOutlet weak var accidentDescription: UILabel!
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.accidentPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        
        self.product.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.accidentTitle.text = t?.name
                self.accidentDescription.text = t?.text?.htmlToString
            }
        })
//        accidentTitle.text = product.translates?[translatePosition]?.name
        
//        accidentDescription.text
//            = product.translates?[translatePosition]?.text?.htmlToAttributedString?.string
        self.accidentDescription.textAlignment = .justified
        self.accidentPresenter?.setProduct(product: product)
        self.setTabBarHidden(true)
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
        self.accidentPresenter?.openAccident1VC()
    }
    
}
