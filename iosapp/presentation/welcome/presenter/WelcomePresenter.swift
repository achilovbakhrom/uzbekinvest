//
//  WelcomePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
protocol WelcomePresenterProtocol: BasePresenter {    
    func languageSelected(lang: String)
    func nextButtonClicked()
}

class WelcomePresenter: WelcomePresenterProtocol {
    
    
    var view: UIViewController?
    var interactor: BaseInteractor?
    var router: BaseRouter?
    
    lazy var welcomeInteractor: WelcomeInteractorProtocol? = {
        return self.interactor as? WelcomeInteractorProtocol
    }()
    
    lazy var welcomeRouer: WelcomeRouterProtocol? = {
        return self.router as? WelcomeRouterProtocol
    }()
    
    func languageSelected(lang: String) {
        self.welcomeInteractor?.setLanguage(lang: lang)        
    }
    
    func nextButtonClicked() {
        self.welcomeRouer?.openSlider()
    }
    
}
