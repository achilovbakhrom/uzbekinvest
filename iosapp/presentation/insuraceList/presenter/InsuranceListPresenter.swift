//
//  InsuranceListPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol InsuranceListPresenter: BasePresenter {
    func setProductList(productList: Array<Product>)
    func setCategoryList(categoryList: Array<Category>)
    func fetchCategoryList()
    func error(msg: String)
    func openInsurance(product: Product?)
    func setLoading(isLoading: Bool)
    func goBack()
}

class InsuranceListPresenterImpl: InsuranceListPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var insuranceListInteractor = self.interactor as? InsuranceListInteractor
    private lazy var insuranceListRouter = self.router as? InsuranceListRouter
    
    func setProductList(productList: Array<Product>) {
        let vc = self.view as? InsuranceListVC
        vc?.setProducts(productList: productList)
    }
    
    func setCategoryList(categoryList: Array<Category>) {
        let vc = self.view as? InsuranceListVC
        vc?.setCategories(categoryList: categoryList)
    }
    
    func fetchCategoryList() {
        self.insuranceListInteractor?.fetchCategoryList(showLoading: true)
    }
    
    func error(msg: String) {
        let vc = self.view as? InsuranceListVC
        vc?.showErrorMessage(msg: msg)
    }
    
    func openInsurance(product: Product?) {
        switch product?.name {
        case "osago":
            self.insuranceListRouter?.openOsago(product: product!)
            break
        case "kasko":
            self.insuranceListRouter?.openKasko(product: product!)
            break
        case "my-life":
            self.insuranceListRouter?.openKasko(product: product!)
            break;
        case "pledged-transport":
            self.insuranceListRouter?.openMandatory(product: product!)
            break
        case "my-family":
            self.insuranceListRouter?.openHome(product: product!)
            break
        case "pledged-property":
            self.insuranceListRouter?.openIpoteka(product: product!)
            break
        case "health-insurance":
            self.insuranceListRouter?.openHealth(product: product!)
            break
        case "my-health":
            self.insuranceListRouter?.openAccident(product: product!)
            break
        case "travel":
            self.insuranceListRouter?.openTravel(product: product!)
            break
        case "sport-accident":
            self.insuranceListRouter?.openSport(product: product!)
            break
        case "technical-help":
            self.insuranceListRouter?.openRoadTech(product: product!)
            break
        case "gas-home":
            self.insuranceListRouter?.openGasHome(product: product!)
            break
        case "gas-auto":
            self.insuranceListRouter?.openGasAuto(product: product!)
            break
        case "infectious-disease":
            self.insuranceListRouter?.openInfection(product: product!)
            break
        case "mobile-phone":
            self.insuranceListRouter?.openMobilePhone(product: product!)
            break
        case "luggage-out":
            self.insuranceListRouter?.openLuggage(product: product!)
            break
        default:
            break
        }
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? InsuranceListVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func goBack() {
        self.insuranceListRouter?.goBack()
    }
    
}
