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
            self.infoView.requestSentDesc.text = "request_send_desc".localized()
            self.infoView.acceptedDescLabel.text = ""
            self.infoView.documentsDesc.text = ""
            self.infoView.decidedDescription.text = ""
            self.infoView.doneDescription.text = ""
            break
        case "canceled":
            self.infoView.stepView.currentStep = 0
            self.infoView.statusLabel.text = "incident_cancelled".localized()
            
            self.infoView.requestSentDesc.text = ""
            self.infoView.acceptedDescLabel.text = ""
            self.infoView.documentsDesc.text = ""
            self.infoView.decidedDescription.text = ""
            self.infoView.doneDescription.text = ""
            break
        case "valid":
            self.infoView.stepView.currentStep = 3
            self.infoView.statusLabel.text = "incident_doc".localized()
            self.infoView.requestSentDesc.text = ""
            self.infoView.acceptedDescLabel.text = "document_desc".localized()
            self.infoView.documentsDesc.text = ""
            self.infoView.decidedDescription.text = ""
            self.infoView.doneDescription.text = ""            
            break
        case "confirmed":
            self.infoView.stepView.currentStep = 2
            self.infoView.statusLabel.text = "incident_confirmed".localized()
            
            self.infoView.requestSentDesc.text = ""
            self.infoView.acceptedDescLabel.text = "accepted_desc".localized()
            self.infoView.documentsDesc.text = ""
            self.infoView.decidedDescription.text = ""
            self.infoView.doneDescription.text = ""
            
            
            break
        case "paid":
            self.infoView.statusLabel.text = "incident_paid".localized()
            self.infoView.stepView.currentStep = 5
            
            self.infoView.requestSentDesc.text = ""
            self.infoView.acceptedDescLabel.text = ""
            self.infoView.documentsDesc.text = ""
            self.infoView.decidedDescription.text = ""
            self.infoView.doneDescription.text = "done_desc1".localized() + " \(incident.order?.totalAmount?.toDecimalFormat() ?? "0") " + "done_desc2".localized()
            
            break
        case "denied":
            self.infoView.statusLabel.text = "incident_completed".localized()
            self.infoView.stepView.currentStep = 4
            
            self.infoView.requestSentDesc.text = ""
            self.infoView.acceptedDescLabel.text = ""
            self.infoView.documentsDesc.text = ""
            self.infoView.decidedDescription.text = "decided_desc".localized()
            self.infoView.doneDescription.text = ""
            
            break
        default:
            break
        }
        self.infoView.incidentAmount.text = "\(self.incident.order?.premiumAmount?.toDecimalFormat() ?? "0") \("sum".localized())"
        infoView.onBack = { self.infoPresenter?.goBack() }
        self.setTabBarHidden(true)
        self.infoPresenter?.fetchMetadata(code: incident.order?.product?.name ?? "travel")        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    
    func setDescription(desc: String) {
        UIView.animate(withDuration: 0.3) {
            self.infoView.descriptionLabel.text = desc.htmlToString
        }
    }
}
