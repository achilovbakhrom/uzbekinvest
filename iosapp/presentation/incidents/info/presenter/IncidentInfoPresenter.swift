//
//  IncidentInfoPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
 
protocol IncidentInfoPresenter: BasePresenter {
    func goBack()
    func fetchMetadata(code: String)
    func setDescription(desc: String)
}

class IncidentInfoPresenterImpl: IncidentInfoPresenter {
    
    var router: BaseRouter?
    var view: UIViewController?
    var interactor: BaseInteractor?
    
    private lazy var infoRouter = self.router as? IncidentInfoRouter
    
    private lazy var infoInteractor = self.interactor as? IncidentInfoInteractor
    
    func goBack() {
        self.infoRouter?.goBack()
    }
    
    func fetchMetadata(code: String) {
        self.infoInteractor?.fetchMetadata(code: code)
    }
    
    func setDescription(desc: String) {
        (self.view as? IncidentsInfoVC)?.setDescription(desc: desc)
    }
}
