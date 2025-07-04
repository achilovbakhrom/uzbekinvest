//
//  IncidentsListingPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsListingPresenter: BasePresenter {
    func openDetailPage()
    func fetchIncidents()
    func setLoading(isLoading: Bool)
    func setIncidents(incidents: [Incident])
    func openLoginVC(phone: String)
    func openIncidentInfo(incident: Incident)
    func showError(msg: String)
    func showSuccess(msg: String)
    func callback(phone: String)
    func setCallbackLoading(isLoading: Bool)
    func dismissCallbackAlert(completed: @escaping () -> Void)
    func openChatVC()
}

class IncidentsListingPresenterImpl: IncidentsListingPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
        
    private lazy var incidentsListingRouter = self.router as? IncidentsListingRouter
    private lazy var incidentsListingInteractor = self.interactor as? IncidentsInteractor
    
    func openDetailPage() {
        self.incidentsListingRouter?.openDetailPage()
    }
    
    func fetchIncidents() {
        self.incidentsListingInteractor?.fetchIncidents()
    }
    
    func openIncidentInfo(incident: Incident) {
        self.incidentsListingRouter?.openIncidentInfo(incident: incident)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? IncidentViewController
        vc?.setLoading(isLoading: isLoading)
    }
    
    func setIncidents(incidents: [Incident]) {
        let vc = self.view as? IncidentViewController
        vc?.setMode(isEmpty: incidents.isEmpty)
        vc?.setIncidentsList(incidents: incidents)
    }
    func openLoginVC(phone: String) {
        self.incidentsListingRouter?.openLoginVC(phone: phone)
    }
    
    func showError(msg: String) {
        self.view?.showSuccessMessage(msg: msg)
    }
    
    func showSuccess(msg: String) {
        self.view?.showSuccessMessage(msg: msg)
    }
    
    func callback(phone: String) {
        self.incidentsListingInteractor?.callback(phone: phone)
    }
    
    func setCallbackLoading(isLoading: Bool) {
        if let v = self.view as? IncidentViewController {
            v.setCallbackLoading(isLoading: isLoading)
        }
    }
    func dismissCallbackAlert(completed: @escaping () -> Void) {
        if let v = self.view as? IncidentViewController {
            v.dissmissAlert(completion: completed)
        }
    }
    
    func openChatVC() {
        self.incidentsListingRouter?.openChatVC()
    }
}

