//
//  IncidentsInfoVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentsInfoVC: BaseViewImpl {
    
    private lazy var infoView: IncidentsInfoView = IncidentsInfoView.fromNib()
    
    var incident: Incident!
    
    private lazy var infoPresenter = self.presenter as? IncidentInfoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(infoView)
        NSLayoutConstraint.activate([
            self.infoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.infoView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.infoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        infoView.incidentName.text = incident.order?.product?.translates?[0]?.name
        infoView.incidentAmount.text = "\(incident.order?.totalAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        
        switch incident.status ?? "" {
        case "new":
            self.infoView.stepView.currentStep = 1
            self.infoView.statusLabel.text = "incident_new".localized()
            break
        case "canceled":
            self.infoView.stepView.currentStep = 0
            self.infoView.statusLabel.text = "incident_cancelled".localized()
            break
        case "confirmed":
            self.infoView.stepView.currentStep = 2
            self.infoView.statusLabel.text = "incident_confirmed".localized()
            break
        case "paid":
            self.infoView.statusLabel.text = "incident_paid".localized()
            self.infoView.stepView.currentStep = 5
            break
        case "denied":
            self.infoView.statusLabel.text = "incident_completed".localized()
            self.infoView.stepView.currentStep = 4
            break
        default:
            break
        }
        self.infoView.incidentAmount.text = "\(self.incident.order?.premiumAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        infoView.onBack = { self.infoPresenter?.goBack() }
        self.setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
}
