//
//  HomePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/26/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenter {
    func openHome1VC()
    func openHomeConfirmVC()
    func openHomeFinalVC()
    func setType(type: Int, typeString: String)
    func calculateHome()
    func setTotalAmount(amount: String)
    func setLoading(isLoading: Bool)
    func fillConfirmData()
    func goBack()
    func setProduct(product: Product)    
    func applyInsuranceClicked()
}

class HomePresenterImpl: BaseInsurancePresenter, HomePresenter {
    
    private lazy var homeInteractor = self.interactor as? HomeInteractor
    private lazy var homeRouter = self.router as? HomeRouter
    
    var home: Home
    
    var typeString: String = ""
    
    override init() {
        home = Home()
    }
    
    func openHome1VC() {
        self.homeRouter?.openHome1VC()
    }
    
    func openHomeConfirmVC() {
        self.homeRouter?.openHomeConfirmVC()
    }
    
    func openHomeFinalVC() {
        self.homeRouter?.openFinalVC()
    }
    
    func setType(type: Int, typeString: String) {
        self.home.type = type
        self.typeString = typeString
    }
    
    func calculateHome() {
        self.homeInteractor?.calculateHome(home: home)
    }
    
    func setTotalAmount(amount: String) {
        let vc = self.view as? HomeConfirmVC
        vc?.setTotalAmount(amount: amount)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? HomeConfirmVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func fillConfirmData() {
        let vc = self.view as? HomeConfirmVC
        vc?.setType(type: typeString)
    }
    
    func applyInsuranceClicked() {
        self.homeInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    override func confirmButtonClicked() {
        self.homeInteractor?.createInsurance(type: .myHome, params: home.dictionary!, amount: totalAmount, startDate: startDate, paymentMethod: self.paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
    
}
