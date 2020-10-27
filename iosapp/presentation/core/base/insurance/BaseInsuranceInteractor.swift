//
//  File.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

enum InsuranceType: String {
    case infection = "disease"
    case gasAuto = "gas-auto"
    case gasHome = "gas-home"
    case luggage = "luggage-out"
    case phone = "phone"
    case sport
    case technicalHelp = "technical-help"
    case medical = "medical-insurance"
    case myHome = "my-home"
    case myHealth = "my-health"
    case pledgedProperty = "pledged-property"
    case pledgedTransport = "pledged-transport"
    case kasko
    case travel
    case osago    
}

class BaseInsuranceInteractor: BaseInteractor {
    internal var presenter: BasePresenter?
    
    private lazy var insurancePresenter = self.presenter as? BaseInsurancePresenter
    
    internal var serviceFactory: ServiceFactoryProtocol!
    
    func uploadFile(data: Data, documentId: Int, name: String, sequence: Int, isMain: Bool = true) {
        self.insurancePresenter?.setUploading(isUploading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.uploadFile(data: data, documentId: documentId, name: name)) { [unowned self] result in
                self.insurancePresenter?.setUploading(isUploading: false)
                switch result {
                case .success(let response):
                    do {
                        debugPrint("Success")
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(ArrayResponse<UserFile>.self, from: response.data)
                        if isMain {
                            self.insurancePresenter?.setMainDocument(documentId: documentId, file: result.data![0])
                        } else {
                            self.insurancePresenter?.setSecondaryDocument(sequence: sequence, documentId: documentId, userFile: result.data![0])
                        }
                        self.fetchUserFiles()
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func fetchDocumentsByProductid(id: Int, request: @escaping (Bool) -> Void) {
        request(true)
        self.serviceFactory.networkManager.user.request(.fetchDocumentById(id: id)) { [unowned self] r in
            switch r {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response<DocsResponse>.self, from: response.data)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.insurancePresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        self.insurancePresenter?.setDocuments(documents: result.data!)
                        self.fetchUserFiles(request: request)
                    }
                } catch (let error) {
                    request(false)
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                request(false)
                debugPrint(error.localizedDescription)
                break
            }
            
        }
    }
    
    func fetchUserFiles(request: ((Bool) -> Void)? = nil) {
        fetchUserFiles(cb: {
        }, request: request)
    }
    
    private func fetchUserFiles(cb: @escaping () -> Void, request: ((Bool) -> Void)? = nil) {
        self.serviceFactory.networkManager.user.request(.fetchUserFiles) { [unowned self] r in
            switch r {
            case .success(let response):
                request?(false)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ArrayResponse<UserFile>.self, from: response.data)
                    if response.statusCode == 401 {
                        let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                        self.serviceFactory.storage.removeKey(key: "profile")
                        self.serviceFactory.tokenFactory.removeToken()
                        self.insurancePresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                    } else {
                        self.insurancePresenter?.setUserFiles(userFiles: result.data ?? [])
                        cb()
                    }
                } catch (let error) {
                    self.insurancePresenter?.setUserFiles(userFiles: [])
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                request?(false)
                self.insurancePresenter?.setUserFiles(userFiles: [])
                debugPrint(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchRegions() {
        self
            .serviceFactory
            .networkManager
            .regions
            .request(.getAllRegions) { [unowned self] result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let result = try decoder.decode(ArrayResponse<Region>.self, from: response.data)
                        self.insurancePresenter?.setRegions(regions: result.data ?? [])
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func createInsurance(type: InsuranceType, params: [String: Any], amount: Int?, startDate: String, paymentMethod: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int = 0, secondaryFils: [Int: [Int: UserFile]]? = nil, long: Double, lat: Double) {
        self.insurancePresenter?.setConfirmButtonEnabled(isEnabled: false)
        self
            .serviceFactory
            .networkManager
            .orders
            .request(.createInsurance(url: type.rawValue, params: params, amount: amount, startDate: startDate, paymentType: paymentMethod, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFils, long: long, lat: lat)) { [unowned self] result in
                switch result {
                case .success:
                    self.insurancePresenter?.openMyInsurances()
                    break
                case .failure(let error):
                    self.insurancePresenter?.setConfirmButtonEnabled(isEnabled: true)
                    debugPrint("error: \(error.localizedDescription)")
                    break
                }
        }
    }
}
