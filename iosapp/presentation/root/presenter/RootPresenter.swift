//
//  RootPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol RootPresenterProtocol: BasePresenter {
    func initialCheck()
}

enum Languages: String {
    case uz = "uz-UZ", ru = "ru", uzCyrl = "uz-Cyrl"
}

class RootPresenter: RootPresenterProtocol {
    
    var view: UIViewController?
    var interactor: BaseInteractor?
    var router: BaseRouter? = nil
    
    lazy var rootInteractor: RootInteractorProtocol? = {
        return self.interactor as? RootInteractorProtocol
    }()
    
    lazy var rootRouter: RootRouterProtocol? = {
        return self.router as? RootRouterProtocol
    }()
    
    func initialCheck() {
        if (!(self.rootInteractor?.hasLanguageSelected() ?? false)) {
            self.rootRouter?.openStartPage()
        } else if (self.rootInteractor?.hasToken() ?? false) {
            self.rootRouter?.openMainPage()
        } else {
            self.rootRouter?.openLoginPage()
        }        
    }
    
}
