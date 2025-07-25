//
//  TravelVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class TravelVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descripttionLabel: UILabel!
    @IBOutlet weak var nextButton: Button!
    
    var product: Product!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.travelPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.setTabBarHidden(true)
        self.product.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.titleLabel.text = t?.name
                self.descripttionLabel.text = t?.text?.htmlToString
            }
        })
        self.descripttionLabel.textAlignment = .justified
        self.travelPresenter?.setProduct(product: product)
        
        self.setupNoInternetView()
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            break
        }
        self.nextButton.setTitle("calculate_the_cost".localized(), for: .normal)
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravel1VC()
    }
    
}
