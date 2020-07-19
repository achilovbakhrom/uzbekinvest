//
//  IncidentsDetailPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/14/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsDetailPresenter: BasePresenter {
    func goBack()
    func setLoading(isLoading: Bool)
    func setInsurances(insurances: [MyInsurance])
    func setEnabled(isEnabled: Bool)
    func openLoginVC(phone: String)
    func fetchIncidents()
    func fetchPinflOrders()
    func openAddEditVC(orderId: Int, productCode: String, isOffline: Int)
    func openInsuranceListVC()
}

class IncidentsDetailPresenterImpl: IncidentsDetailPresenter {
    
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var incidentsRouter = self.router as? IncidentsDetailRouter
    private lazy var incidentsInteractor = self.interactor as? IncidentsDetailInteractor
    
    func goBack() {
        self.incidentsRouter?.goBack()
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? IncidentsDetailListingVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func setEnabled(isEnabled: Bool) {
        
    }
    
    
    func fetchIncidents() {
        self.incidentsInteractor?.fetchIncidents()
    }
    
    func setInsurances(insurances: [MyInsurance]) {
        if let vc = self.view as? IncidentsDetailListingVC {
            vc.setInsurances(insurances: insurances)
        }
    }
    
    func openLoginVC(phone: String) {
        self.incidentsRouter?.openLoginVC(phone: phone)
    }
    
    func openAddEditVC(orderId: Int, productCode: String, isOffline: Int) {
        self.incidentsRouter?.openAddEditVC(orderId: orderId, productCode: productCode, isOffline: isOffline)
    }
    
    func fetchPinflOrders() {
        self.incidentsInteractor?.fetchPinflOrders()
    }
    
    func openInsuranceListVC() {
        self.incidentsRouter?.openInsuranceListVC()
    }
}
