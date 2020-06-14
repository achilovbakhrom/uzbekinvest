//
//  FaqPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol FaqPresenter: BasePresenter {
    func goBack()
    func fetchFaqList()
    func setLoading(isLoading: Bool)
    func setFaqList(list: [Question])
    func showError(msg: String)
}

class FaqPresenterImpl: FaqPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var faqView = self.view as? FaqVC
    private lazy var faqInteractor = self.interactor as? FaqInteractor
    private lazy var faqRouter =  self.router as? FaqRouter
    
    func goBack() {
        self.faqRouter?.goBack()
    }
    
    func fetchFaqList() {
        self.faqInteractor?.fetchFaqList()
    }
    
    func setLoading(isLoading: Bool) {
        self.faqView?.setLoading(isLoading: isLoading)
    }
    
    func setFaqList(list: [Question]) {
        self.faqView?.setFaqList(list: list)
    }
    
    func showError(msg: String) {
        self.faqView?.showErrorMessage(msg: msg)
    }
    
}
