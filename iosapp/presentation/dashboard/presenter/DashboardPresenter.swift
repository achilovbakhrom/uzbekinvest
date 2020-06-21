//
//  DashboardRouter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardPresenter: BasePresenter {
    func setProductList(productList: Array<Product>)
    func setCategoryList(categoryList: Array<Category>)
    func fetchCategoryList()
    func fetchCarouselData()
    func setLoading(isLoading: Bool)
    func openInsurance(product: Product?)
    func setCarouselLoading(isLoading: Bool)
    func setCarouselList(carouselList: [Carousel])
    func openCheckOrderVC()
    func openIncidentsVC()
    func openSupportVC()
    func error(msg: String)
    func openNotifications()
    func setFCMToken(token: String)
}

class DashboardPresenterImpl: DashboardPresenter {
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var dashboardInteractor = self.interactor as? DashboardInteractor
    
    private lazy var dashboardRouter = self.router as? DashboardRouter
    
    func fetchCategoryList() {
        self.dashboardInteractor?.fetchCategoryList(showLoading: true)
    }
        
    func fetchCarouselData() {
        self.dashboardInteractor?.fetchCarouselData()
    }
    
    func setProductList(productList: Array<Product>) {
        let vc = self.view as? DashboardVC
        vc?.setProductList(productList: productList)
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? DashboardVC
        vc?.setLoading(isLoading: isLoading)
    }
    
    func setCategoryList(categoryList: Array<Category>) {
        let vc = self.view as? DashboardVC
        vc?.setCategoryList(categoryList: categoryList)
    }
    
    func openInsurance(product: Product?) {
        switch product?.name {
        case "osago":
            self.dashboardRouter?.openOsago(product: product!)
            break
        case "kasko":
            self.dashboardRouter?.openKasko(product: product!)
            break
        case "my-life":
            self.dashboardRouter?.openKasko(product: product!)
            break;
        case "pledged-transport":
            self.dashboardRouter?.openMandatory(product: product!)
            break
        case "my-family":
            self.dashboardRouter?.openHome(product: product!)
            break
        case "pledged-property":
            self.dashboardRouter?.openIpoteka(product: product!)
            break
        case "health-insurance":
            self.dashboardRouter?.openHealth(product: product!)
            break
        case "my-health":
            self.dashboardRouter?.openAccident(product: product!)
            break
        case "travel":
            self.dashboardRouter?.openTravel(product: product!)
            break
        case "sport-accident":
            self.dashboardRouter?.openSport(product: product!)
            break
        case "technical-help":
            self.dashboardRouter?.openRoadTech(product: product!)
            break
        case "gas-home":
            self.dashboardRouter?.openGasHome(product: product!)
            break
        case "gas-auto":
            self.dashboardRouter?.openGasAuto(product: product!)
            break
        case "infectious-disease":
            self.dashboardRouter?.openInfection(product: product!)
            break
        case "mobile-phone":
            self.dashboardRouter?.openMobilePhone(product: product!)
            break
        case "luggage-out":
            self.dashboardRouter?.openLuggage(product: product!)
            break
        default:
            break
        }
    }
    
    func setFCMToken(token: String) {
        self.dashboardInteractor?.setFCMToken(token: token)
    }
    
    func setCarouselList(carouselList: [Carousel]) {
        let vc = self.view as? DashboardVC
        vc?.setCarouselList(carouselList: carouselList)
    }
    
    func setCarouselLoading(isLoading: Bool) {
        let vc = self.view as? DashboardVC
        vc?.setCarouselLoading(isLoading: isLoading)
    }
    
    func openCheckOrderVC() {
        self.dashboardRouter?.openCheckOrderVC()
    }
    
    func openIncidentsVC() {
        self.dashboardRouter?.openIncidentsVC()
    }
    func openSupportVC() {
        self.dashboardRouter?.openSupportVC()
    }
    
    func error(msg: String) {
        let vc = self.view as? DashboardVC
        vc?.showErrorMessage(msg: msg)
    }
    
    func openNotifications() {
        self.dashboardRouter?.openNotifications()
    }
}
