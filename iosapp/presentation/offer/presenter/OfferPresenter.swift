//
//  OfferPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol OfferPresenter: BasePresenter {
    func goBack()
    func goNext()
    func fetchOffer()
    func setLoading(isLoading: Bool)
    func setOfferText(text: String)
}


class OfferPresenterImpl: OfferPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var offerView: OfferVC = self.view as! OfferVC
    private lazy var offerInteractor: OfferInteractor = self.interactor as! OfferInteractor
    private lazy var offerRouter: OfferRouter = self.router as! OfferRouter
    
    func goBack() {
        self.offerRouter.goBack()
    }
    
    func goNext() {
        self.offerRouter.openMain()
    }
    
    func fetchOffer() {
        self.offerInteractor.fetchOffer()
    }
    
    func setLoading(isLoading: Bool) {
        self.offerView.setLoading(isLoading: isLoading)
    }
    
    func setOfferText(text: String) {
        self.offerView.setOfferText(text: text)
    }
    
}
