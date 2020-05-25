//
//  BaseInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol BaseInteractor: class {
    var presenter: BasePresenter? { get set } 
}
