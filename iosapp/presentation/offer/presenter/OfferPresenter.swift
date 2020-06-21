//
//  OfferPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol OfferPresenter: BasePresenter {
    func goBack()
    func goNext()
    func fetchOffer()
    func setLoading(isLoading: Bool)
}
