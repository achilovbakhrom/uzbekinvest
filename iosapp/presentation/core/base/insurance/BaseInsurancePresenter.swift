//
//  BaseInsurancePresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class BaseInsurancePresenter: BasePresenter {
    
    internal var interactor: BaseInteractor?
    internal var router: BaseRouter?
    internal var view: UIViewController?
    internal var product: Product? = nil
    internal var totalAmount:Int = 0
    internal var formatAmount: String = ""
    internal var params: [String: Any] = [:]
    internal var userFiles: [UserFile] = []
    internal var documents: [Document] = []
    internal var secondary: [Document] = []
    internal var mainFiles: [Int: UserFile] = [:]
    internal var secondaryFiles: [Int: [Int: UserFile]]? = nil
    internal var regionId: Int = -1    
    internal var startDate: String = ""
    internal var membersCount: Int = 0
    internal var paymentType: String = "online"
    internal var regions: [Region] = []
    
    private lazy var insuranceInteractor = self.interactor as? BaseInsuranceInteractor
    private var baseInsuranceView: BaseInsuranceConfirmVC? {
        get {
            return self.view as? BaseInsuranceConfirmVC
        }
    }
    
    func goBack() {
        let r = self.router as? BaseInsuranceRouter
        r?.goBack()
    }
    
    func uploadFile(data: Data, documentId: Int, name: String, isMain: Bool, sequence: Int = 0) {
        self.insuranceInteractor?.uploadFile(data: data, documentId: documentId, name: name, sequence: sequence, isMain: isMain)
    }
    
    func setMainDocument(documentId: Int, file: UserFile) {
        mainFiles[documentId] = file
        self.setMainDocumentName(documentId: documentId, name: file.name)
        self.checkConfirmButton()
    }
    
    func setMainDocumentName(documentId: Int, name: String) {
        baseInsuranceView?.setMainDocumentName(documentId: documentId, name: name)
    }
    
    func setSecondaryDocument(sequence: Int, documentId: Int, userFile: UserFile) {
        if secondaryFiles == nil { secondaryFiles = [:] }
        
        if self.secondaryFiles?[sequence] != nil{
            self.secondaryFiles?[sequence]?[documentId] = userFile
        } else {
            let pair: [Int: UserFile] = [documentId: userFile]
            self.secondaryFiles?[sequence] = pair
        }
        
        self.setSecondaryDocumentName(sequence: sequence, documentId: documentId, name: userFile.name)
        self.checkConfirmButton()
    }
    
    func setSecondaryDocumentName(sequence: Int, documentId: Int, name: String) {
        baseInsuranceView?.setSecondaryDocumentName(sequence: sequence, documentId: documentId, name: name)
    }
    
    func setRegions(regions: [Region]) {
        self.regions = regions
        if regions.count > 0 {
            let r = regions[0]
            if (r.children ?? []).isEmpty {
                self.regionId = self.regions[0].id
            } else {
                self.regionId = r.children?[0]?.id ?? 0
            }
        }
        baseInsuranceView?.setRegions(regions: regions)
    }
    
    func setPaymentType(paymentType: Int) {
        switch paymentType {
        case 0:
            self.paymentType = "online"
        case 1:
            self.paymentType = "cash"
        case 2:
            self.paymentType = "terminal"
        default:
            self.paymentType = "online"
        }        
    }
    
    func setStartDate(startDate: String) {
        self.startDate = startDate
    }
    
    func setRegionId(regionId: Int) {
        self.regionId = regionId
    }
    
    func checkConfirmButton() {
        
        let vc = self.view as? BaseInsuranceConfirmVC
        
        if documents.count == 0 {
            vc?.setConfirmButtonEnabled(isEnabled: true)
        } else if membersCount == 0 {
            vc?.setConfirmButtonEnabled(isEnabled: mainFiles.count == documents.count)
        } else {
            if let s = secondaryFiles, s.count == membersCount {
                var isEnabled = true
                (0..<s.count).forEach { i in
                    if s[i]?.count != secondary.count {
                        isEnabled = false
                        return;
                    }
                }
                vc?.setConfirmButtonEnabled(isEnabled: isEnabled)
            } else {
                vc?.setConfirmButtonEnabled(isEnabled: false)
            }
        }
    }
    
    func setUploading(isUploading: Bool) {
        baseInsuranceView?.setUploading(isUploading: isUploading)
    }
    
    func openLoginVC(phone: String) {
        let r = self.router as? BaseInsuranceRouter
        r?.openLoginVC(phone: phone)
    }
    
    func setUserFiles(userFiles: [UserFile]) {
        self.userFiles = userFiles
        self.baseInsuranceView?.setUserFiles(userFiles: userFiles)
    }
    
    func setConfirmButtonEnabled(isEnabled: Bool) {
        self.baseInsuranceView?.setConfirmButtonEnabled(isEnabled: isEnabled)
    }
    
    func openFinalVC() {
        let r = self.router as? BaseInsuranceRouter
        r?.openFinalVC()
    }
    
    func openMyInsurances() {
        let r = self.router as? BaseInsuranceRouter
        r?.openMyInsurances()
    }
    
    
    func setDocuments(documents: DocsResponse) {
        self.documents = documents.mainDocs ?? []
        self.secondary = documents.secondaryDocs ?? []
        
    }
    
    func confirmButtonClicked() {}
    
    func setupFinalVC() {
        self.product?.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.baseInsuranceView?.setInsuranceName(name: t?.name ?? "")
            }
        })        
        self.baseInsuranceView?.setInsuranceAmount(amount: self.formatAmount)
        self.baseInsuranceView?.setup(totalAmount: self.formatAmount, documents: self.documents, secondary: self.secondary, userFiles: self.userFiles, membersCount: self.membersCount)
        self.insuranceInteractor?.fetchRegions()
    }
    
    
    
}

