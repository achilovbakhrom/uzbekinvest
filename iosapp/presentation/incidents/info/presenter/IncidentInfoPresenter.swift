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
}

class IncidentInfoPresenterImpl: IncidentInfoPresenter {
    
    var router: BaseRouter?
    var view: UIViewController?
    var interactor: BaseInteractor?
    
    private lazy var infoRouter = self.router as? IncidentInfoRouter
    
    func goBack() {
        self.infoRouter?.goBack()
    }
    
}
