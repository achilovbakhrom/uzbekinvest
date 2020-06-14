//
//  ReasonVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/6/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class ReasonVC: BaseViewImpl {
    
    let reasonView: ReasonView = ReasonView.fromNib()
    
    private lazy var incidentAddEditPresenter = self.presenter as? IncidentsAddEditPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(reasonView)
        self.reasonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.reasonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.reasonView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.reasonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.reasonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.reasonView.onBack = {
            self.incidentAddEditPresenter?.goBack()
        }
        self.reasonView.onType = {
            self.incidentAddEditPresenter?.setType(type: $0)
        }
        
        self.reasonView.onDate = {
            self.incidentAddEditPresenter?.setDate(date: $0)
        }
        
        self.reasonView.onTime = {
            self.incidentAddEditPresenter?.setTime(time: $0)
        }
        
        self.reasonView.onNext = {
            
            self.incidentAddEditPresenter?.openCommentVC()
        }
        
        self.incidentAddEditPresenter?.fetchIncidentMetaData()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.reasonView.onNextButton.isEnabled = isEnabled
    }
    
    func setIncidentMetaData(list: IncidentMetaItem) {
        self.reasonView.setIncidentMetaData(list: list)
    }
}
