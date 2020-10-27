//
//  MyDocumentsPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MyDocumentsInteractor: BaseInteractor {
    
    func loadDocuments()
    func removeFile(id: Int)
    func uploadFile(data: Data, documentId: Int, name: String)
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    
}

class MyDocumentsInteractorImpl: MyDocumentsInteractor {
    var presenter: BasePresenter?
    var serviceFactory: ServiceFactoryProtocol?
    
    private lazy var myDocumentsPresenter = self.presenter as? MyDocumentsPrsenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    func loadDocuments() {
        self.myDocumentsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .user
            .request(.fetchUserFiles, completion: { [unowned self] result in
                switch result {
                case .success(let response):
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory?.storage.removeKey(key: "profile")
                        self.serviceFactory?.tokenFactory.removeToken()
                        self.myDocumentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(ArrayResponse<UserFile>.self, from: response.data)
                            self.myDocumentsPresenter?.setUserFiels(files: r.data ?? [])
                            self.fetchDocs()
                        } catch (let error) {
                            self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                            debugPrint(error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.myDocumentsPresenter?.setLoading(isLoading: false)
                    self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
            })
    }
    
    private func fetchDocs() {
        self.serviceFactory?
            .networkManager
            .user
            .request(.availableDocuments) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.myDocumentsPresenter?.setLoading(isLoading: false)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory?.storage.removeKey(key: "profile")
                        self.serviceFactory?.tokenFactory.removeToken()
                        self.myDocumentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        do {
                            let decoder = JSONDecoder.init()
                            let r = try decoder.decode(ArrayResponse<Document>.self, from: response.data)
                            self.myDocumentsPresenter?.setDocuments(documents: r.data ?? [])
                        } catch (let error) {
                            self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                            debugPrint(error.localizedDescription)
                        }
                    }
                    break
                case .failure(let error):
                    self.myDocumentsPresenter?.setLoading(isLoading: false)
                    self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
                
        }
    }
    
    func removeFile(id: Int) {
        self.myDocumentsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .user
            .request(.removeFile(id: id), completion: { [unowned self] result in
                switch result {
                case .success(let response):
                    
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory?.storage.removeKey(key: "profile")
                        self.serviceFactory?.tokenFactory.removeToken()
                        self.myDocumentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        self.fetchFiles()
                    }
                    break
                case .failure(let error):
                    self.myDocumentsPresenter?.setLoading(isLoading: false)
                    self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
                
            })
    }
    
    private func fetchFiles() {
        self.serviceFactory?
        .networkManager
        .user
        .request(.fetchUserFiles, completion: { [unowned self] result in
            switch result {
            case .success(let response):
                if response.statusCode == 401 {
                    let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                    self.serviceFactory?.storage.removeKey(key: "profile")
                    self.serviceFactory?.tokenFactory.removeToken()
                    self.myDocumentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                } else {
                    self.myDocumentsPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<UserFile>.self, from: response.data)
                        self.myDocumentsPresenter?.setUserFiels(files: r.data ?? [])
                    } catch (let error) {
                        self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                }
                break
            case .failure(let error):
                self.myDocumentsPresenter?.setLoading(isLoading: false)
                self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                debugPrint(error.localizedDescription)
                break
            }
        })
    }
    func uploadFile(data: Data, documentId: Int, name: String) {
        self.myDocumentsPresenter?.setLoading(isLoading: true)
        self.serviceFactory?
            .networkManager
            .user
            .request(.uploadFile(data: data, documentId: documentId, name: name), completion: { [unowned self] result in
                switch result {
                case .success(let response):
                    
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory?.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory?.storage.removeKey(key: "profile")
                        self.serviceFactory?.tokenFactory.removeToken()
                        self.myDocumentsPresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        self.fetchFiles()
                    }
                    break
                case .failure(let error):
                    self.myDocumentsPresenter?.setLoading(isLoading: false)
                    self.myDocumentsPresenter?.shoeError(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    break
                }
                
            })
    }
}
