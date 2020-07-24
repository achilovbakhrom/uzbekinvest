//
//  RoadTechSupportVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class RoadTechSupportVC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var nextButton: Button!
    private lazy var roadTechPresenter = self.presenter as? RoadTechPresenter
    var product: Product!
    
    @IBOutlet weak var techRoadTitle: UILabel!
    @IBOutlet weak var techRoadDescription: UILabel!
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = {
            self.roadTechPresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.setTabBarHidden(true)
        self.roadTechPresenter?.setProduct(product: product)
        self.product.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.techRoadTitle.text = t?.name
                self.techRoadDescription.text = t?.text?.htmlToString
            }
        })
//        techRoadTitle.text = product.translates?[translatePosition]?.name
//        techRoadDescription.text = product.translates?[translatePosition]?.text?.htmlToString
        techRoadDescription.textAlignment = .justified
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
        self.roadTechPresenter?.openTechRoad1VC()
    }
    
}
