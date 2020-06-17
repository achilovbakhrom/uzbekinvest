//
//  MainPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MainPresenter: BasePresenter {
    func getProductById(id: String)
    func setProduct(product: Product)
    func showError(msg: String)
    func setMyInsurance(myInsurance: MyInsurance)
    func getInsuranceById(id: String)
    func getIncidentById(id: String)
    func setIncident(incident: Incident)
}

class MainPresenterImpl: MainPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var mainInteractor = self.interactor as? MainInteractor
    private lazy var mainView = self.view as? MainViewController
    
    func getProductById(id: String) {
        self.mainInteractor?.getProductById(id: id)
    }
    
    func setProduct(product: Product) {
        switch product.name {
        case "osago":
            self.mainView?.openOsago(product: product)
            break
        case "kasko":
            self.mainView?.openKasko(product: product)
            break
        case "my-life":
            self.mainView?.openKasko(product: product)
            break;
        case "pledged-transport":
            self.mainView?.openMandatory(product: product)
            break
        case "my-family":
            self.mainView?.openHome(product: product)
            break
        case "pledged-property":
            self.mainView?.openIpoteka(product: product)
            break
        case "health-insurance":
            self.mainView?.openHealth(product: product)
            break
        case "my-health":
            self.mainView?.openAccident(product: product)
            break
        case "travel":
            self.mainView?.openTravel(product: product)
            break
        case "sport-accident":
            self.mainView?.openSport(product: product)
            break
        case "technical-help":
            self.mainView?.openRoadTech(product: product)
            break
        case "gas-home":
            self.mainView?.openGasHome(product: product)
            break
        case "gas-auto":
            self.mainView?.openGasAuto(product: product)
            break
        case "infectious-disease":
            self.mainView?.openInfection(product: product)
            break
        case "mobile-phone":
            self.mainView?.openMobilePhone(product: product)
            break
        case "luggage-out":
            self.mainView?.openLuggage(product: product)
            break
        default:
            break
        }
    }
    
    func showError(msg: String) {
        self.mainView?.showSuccessMessage(msg: msg)
    }
    
    func setMyInsurance(myInsurance: MyInsurance) {
        self.mainView?.openMyInsurance(myInsurance: myInsurance)
    }
    
    func getInsuranceById(id: String) {
        self.mainInteractor?.getOrderById(id: id)
    }
    
    func getIncidentById(id: String) {
        self.mainInteractor?.getIncidentbyId(id: id)
    }
    
    func setIncident(incident: Incident) {
        self.mainView?.openIncident(incident: incident)
    }
}
