//
//  BaseView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol BaseView {
    var presenter: BasePresenter? { get set }    
    func showLoading()
    func hideLoading()
    func showMessage(msg: String, title: String?)
    func hideMessage()
    func showNetworkError()
    func hideNetworkError()
}
