//
//  OfficesPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol OfficesPresenter: BasePresenter {
    func fetchOfficesList()
    func setOfficesList(list: Array<Office>)
    func setLoading(isLoading: Bool)
    func buildRoute()
    func goBack()
}

class OfficesPresenterImpl: OfficesPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var officesView = view as? OfficesVC
    private lazy var officesInteractor = self.interactor as? OfficesInteractor
    private lazy var officesRouter = router as? OfficesRouter
    
    func fetchOfficesList() {
        self.officesInteractor?.fetchOffices()
    }
    
    func setOfficesList(list: Array<Office>) {
        self.officesView?.setOfficesList(officesList: list)
    }
    
    func setLoading(isLoading: Bool) {
        self.officesView?.setLoading(isLoading: isLoading)
    }
    
    func buildRoute() {
        
    }
    func goBack() {
        self.officesRouter?.goBack()
    }
    
}
