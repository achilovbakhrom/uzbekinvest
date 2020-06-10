//
//  IncidentsAddEditPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol IncidentsAddEditPresenter: BasePresenter {
    var orderId: Int { get set }
    var productCode: String { get set }
    var incident: Incident? { get set }
    func goBack()
    func setLongLat(long: Double, lat: Double)
    func setAddress(address: String)
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func setMode(isMapMode: Bool)
    func openFilesVC()
    func openCommentVC()
    func addFile(name: String, data: Data)
    func removeFile(index: Int)
    func setComment(comment: String)
    func createIncident()
    func openAndUpdateIncidents()
    func openLoginVC(phone: String)
    func fetchIncidentMetaData()
    func setIncidentMetaItemList(list: IncidentMetaItem)
    func openReasonVC()
    func setDate(date: String)
    func setTime(time: String)
    func setType(type: String)
    func setIsOffline(isOffline: Int)
    func createIncidentFromFilesVC()
}

class IncidentsAddEditPresenterImpl: IncidentsAddEditPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    var orderId: Int = 0
    var incident: Incident? = nil
    var isMapMode = true
    var index = 0
    var productCode: String = ""
    
    var date: String? = nil
    var time: String? = nil
    var type: String? = nil
    
    private lazy var incidentsAddEditRouter = self.router as? IncidentsAddEditRouter
    private lazy var incidentsAddEditInteractor = self.interactor as? IncidentsAddEditInteractor
    
    var files: [Int: [String: Data]] = [:]
    
    func goBack() {
        self.incidentsAddEditRouter?.goBack()
    }
    
    func setLongLat(long: Double, lat: Double) {
        if incident == nil {
            incident = Incident()
        }
        incident?.longitude = "\(long)"
        incident?.lattitude = "\(lat)"
        self.setEnabled(isEnabled: true)
    }
    
    func setAddress(address: String) {
        if incident == nil {
            incident = Incident()
        }
        incident?.address = address
        self.setEnabled(isEnabled: !address.isEmpty)
    }
    
    func setMode(isMapMode: Bool) {
        self.isMapMode = isMapMode
        if incident == nil { incident = Incident() }
        if isMapMode {
            self.setEnabled(isEnabled: incident?.longitude != nil && incident?.lattitude != nil)
        } else {
            self.setEnabled(isEnabled: incident?.address != nil)
        }
    }
    
    func setComment(comment: String) {
        self.incident?.comment = comment
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? LocationVC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? CommentsVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func openFilesVC() {
        self.incidentsAddEditRouter?.openFilesVC()
    }
    
    func addFile(name: String, data: Data) {
        self.files[index] = [name: data]
        index += 1
    }
    
    func removeFile(index: Int) {
        self.files.removeValue(forKey: index)
    }
    
    func openCommentVC() {
        self.incidentsAddEditRouter?.openCommentVC()
    }
    
    func createIncident() {
        if productCode == "osago" || productCode == "kasko" || productCode == "my-family" || productCode == "technical-help" || productCode == "mobile-phone" {
            self.incidentsAddEditRouter?.openFilesVC()
        } else {
            self.incident?.orderId = orderId
            self.incidentsAddEditInteractor?.createIncident(incident: self.incident!, type: type ?? "", files: files)
        }
    }
    
    func createIncidentFromFilesVC() {
        self.incident?.orderId = orderId
        self.incidentsAddEditInteractor?.createIncident(incident: self.incident!, type: type ?? "", files: files)
    }
    
    func openAndUpdateIncidents() {
        self.incidentsAddEditRouter?.openAndUpdateIncidents()
    }
    
    func openLoginVC(phone: String) {
        self.incidentsAddEditRouter?.openLoginVC(phone: phone)
    }
    
    func fetchIncidentMetaData() {
        self.incidentsAddEditInteractor?.fetchIncidentMetadata(productCode: productCode)
    }
    
    func setIncidentMetaItemList(list: IncidentMetaItem) {
        if let vc = self.view as? ReasonVC {
            vc.setIncidentMetaData(list: list)
        }
    }
    
    func openReasonVC() {
        self.incidentsAddEditRouter?.openReasonVC()
    }
    
    func setDate(date: String) {
        self.date = date
        if time != nil {
            self.incident?.happenedAt = "\(self.date ?? "") \(self.time ?? "")"
            if let vc = self.view as? ReasonVC {
                vc.setEnabled(isEnabled: true)
            }
        } else {
            if let vc = self.view as? ReasonVC {
                vc.setEnabled(isEnabled: false)
            }
        }
    }
    
    func setTime(time: String) {
        self.time = time
        if date != nil {
            self.incident?.happenedAt = "\(self.date ?? "") \(self.time ?? "")"
            if let vc = self.view as? ReasonVC {
                vc.setEnabled(isEnabled: true)
            }
        } else {
            if let vc = self.view as? ReasonVC {
                vc.setEnabled(isEnabled: false)
            }
        }
    }
    
    func setType(type: String) {
        if date == nil && time == nil {
            if let vc = self.view as? ReasonVC {
                vc.showErrorMessage(msg: "Выберите дату и время")
            }
        } else {
            self.incident?.happenedAt = "\(date ?? "") \(time ?? "")"
            self.type = type
            self.openCommentVC()
        }
    }
    
    func setIsOffline(isOffline: Int) {
        self.incident?.isOffline = isOffline
    }
}
