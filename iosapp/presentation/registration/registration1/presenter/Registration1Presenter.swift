//
//  Registration1Presenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol Registration1PresenterProtocol: BasePresenter {
    func checkData(name: String, dob: String)
}


class Registration1Presenter: Registration1PresenterProtocol {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    
    func checkData(name: String, dob: String) {
        
    }
    
}
