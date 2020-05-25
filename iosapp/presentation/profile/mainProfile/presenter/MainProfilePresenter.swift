//
//  MainProfilePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol MainProfilePresenter: BasePresenter {
    func fetchMe()
    func openOfficesVC()
    func setUser(user: ProfileUser?)
    func setLoading(isLoading: Bool)
    func openLoginVC(phone: String)
    func openMyDocs()
    func openSettings()
}


class MainProfilePresenterImpl: MainProfilePresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var mainProfileRouter = self.router as? MainProfileRouter
    private lazy var mainProfileInteractor = self.interactor as? MainProfileInteractor
    private lazy var mainProfileVC = self.view as? MainProfileVC
    
    func fetchMe() {
        self.mainProfileInteractor?.fetchMe()
    }
    
    func openOfficesVC() {
        self.mainProfileRouter?.openOfficesVC()
    }
    
    func setUser(user: ProfileUser?) {
        self.mainProfileVC?.setUser(user: user)
    }
    
    func setLoading(isLoading: Bool) {
        self.mainProfileVC?.setLoading(isLoading: isLoading)
    }
    
    func openLoginVC(phone: String) {
        self.mainProfileRouter?.openLoginVC(phone: phone)
    }
    
    func openMyDocs() {
        self.mainProfileRouter?.openMyDocs()
    }
    
    
    func openSettings() {
        self.mainProfileRouter?.openSettings()
    }
}
