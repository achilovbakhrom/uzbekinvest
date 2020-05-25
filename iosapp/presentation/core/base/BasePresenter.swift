//
//  BasePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
protocol BasePresenter: class {
    var interactor: BaseInteractor? { get set }
    var router: BaseRouter? { get set }
    var view: UIViewController? { get set }
}
