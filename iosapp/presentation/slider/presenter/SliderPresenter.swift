//
//  SliderPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol SliderPresenterProtocol: BasePresenter {
    func nextButtonClicked()
}

class SliderPresenter: SliderPresenterProtocol {
    
    
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    lazy var sliderRouter: SliderRouterProtocol? = {
        return self.router as? SliderRouterProtocol
    }()
    
    func nextButtonClicked() {
        sliderRouter?.openLoginPage()
    }
    
    
    
}
