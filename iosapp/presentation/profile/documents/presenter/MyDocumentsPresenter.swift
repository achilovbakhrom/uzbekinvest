//
//  MyDocumentsPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


protocol MyDocumentsPrsenter: BasePresenter {
    func loadDocuments()
    func setLoading(isLoading: Bool)
    func openLoginVC(phone: String)
    func shoeError(msg: String)
    func setDocuments(documents: [Document])
    func setUserFiels(files: [UserFile])
    func goBack()
    func removeFile(id: Int)
    func uploadFile(data: Data, documentId: Int, name: String)
}

class MyDocumentsPresenterImpl: MyDocumentsPrsenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private lazy var documentInteractor = self.interactor as? MyDocumentsInteractor
    private lazy var documentsRouter = self.router as? MyDocumentsRouter
    func loadDocuments() {
        self.documentInteractor?.loadDocuments()
    }
    
    func setLoading(isLoading: Bool) {
        let vc = self.view as? MyDocumentsVC
        vc?.setLoading(isLoading: isLoading)
    }
        
    func openLoginVC(phone: String) {
        self.documentsRouter?.openLoginVC(phone: phone)
    }
    
    func shoeError(msg: String) {
        let vc = self.view as? MyDocumentsVC
        vc?.showErrorMessage(msg: msg)
    }
    
    func setDocuments(documents: [Document]) {
        let vc = self.view as? MyDocumentsVC
        vc?.setDocuments(documents: documents)
    }
    
    func goBack() {
        self.documentsRouter?.goBack()
    }
    
    func removeFile(id: Int) {
        self.documentInteractor?.removeFile(id: id)
    }
    
    func setUserFiels(files: [UserFile]) {
        let vc = self.view as? MyDocumentsVC
        vc?.setUserFiles(userFiles: files)
    }
    
    func uploadFile(data: Data, documentId: Int, name: String) {
        self.documentInteractor?.uploadFile(data: data, documentId: documentId, name: name)
    }
}

