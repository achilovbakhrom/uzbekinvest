//
//  MyInsurancesInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol MyInsurancesInteractor: BaseInteractor {
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    func fetchMyInsurances()
    func getShowAgainFlag() -> Bool?
    func fetchPinflList()
}

class MyInsranceInteractorImpl: MyInsurancesInteractor {
    
    var presenter: BasePresenter? = nil
    var serviceFactory: ServiceFactoryProtocol!
    
    private lazy var myInsrancePresenter = self.presenter as? MyInsurancesPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    private func fetchCategoryList(didLoad: @escaping (Bool) -> Void) {
        self
            .serviceFactory?
            .networkManager
            .others
            .request(.fetchCategoryList, completion: { [unowned self] result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let r = try decoder.decode(ArrayResponse<Category>.self, from: response.data)
                    var categoryList = r.data ?? []
                    var c = Category()
                    c.id = -1
                    c.translates = [
                        Translate(name: "Все", lang: "ru", text: nil, description: nil),
                        Translate(name: "Hamma", lang: "uz", text: nil, description: nil),
                        Translate(name: "Хамма", lang: "oz", text: nil, description: nil)
                    ]
                    categoryList.insert(c, at: 0)
                    self.fetchPinfl { hasPinfl in
                        if hasPinfl {
                            var pinflCat = Category()
                            pinflCat.id = -2
                            pinflCat.translates = [
                                Translate(name: "Все ранее купленные", lang: "ru", text: nil, description: nil),
                                Translate(name: "Ilgari sotib olinganlar", lang: "uz", text: nil, description: nil),
                                Translate(name: "Илгари сотиб олинганлар", lang: "oz", text: nil, description: nil)
                            ]
                            categoryList.insert(pinflCat, at: 1)
                            self.fetchPinlOrders()
                        }
                        self.myInsrancePresenter?.setCategoryList(categoryList: categoryList)
                        didLoad(true)
                    }
                    
                } catch (let error) {
                    didLoad(false)
                    debugPrint(error.localizedDescription)
                }
                break
            case .failure(let error):
                didLoad(false)
                debugPrint(error.localizedDescription)
                break
            }
        })
    }
    
    private func fetchPinlOrders() {
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchOrders) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<MyInsurance>.self, from: response.data)
                        self.myInsrancePresenter?.setPinflOrders(pinflOrders: r.data ?? [])
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
    
    private func fetchPinfl(pinflLoaded: @escaping (Bool) -> Void) {
        self
            .serviceFactory
            .networkManager
            .user
            .request(.getPinflList) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<Pinfl>.self, from: response.data)
                        pinflLoaded((r.data?.count ?? 0) > 0)
                    } catch (let error) {
                        pinflLoaded(false)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    pinflLoaded(false)
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
    func fetchMyInsurances() {
        self.myInsrancePresenter?.setLoading(isLoading: true)
        fetchCategoryList { [unowned self] _ in
            self.serviceFactory?
                .networkManager
                .user
                .request(.fetchUserInsurances, completion: { [unowned self] result in
                    self.myInsrancePresenter?.setLoading(isLoading: false)
                    switch result {
                    case .success(let response):
                        if response.statusCode == 401 {
                            let profile = self.serviceFactory.storage.fetchObject(key: "profile", type: AuthResult.self)
                            self.serviceFactory.storage.removeKey(key: "profile")
                            self.serviceFactory.tokenFactory.removeToken()
                            self.myInsrancePresenter?.openLoginVC(phone: "\(profile?.phone ?? 0)")
                        } else {
                            do {
                                let decoder = JSONDecoder.init()
                                let r = try decoder.decode(ArrayResponse<MyInsurance>.self, from: response.data)
                                let jsonString = String(data: response.data, encoding: .utf8)!
                                let properties = PropertyArrayResposne.init(JSONString: jsonString)
                                self.myInsrancePresenter?.setMyInsurances(myInsuranceList: r.data ?? [], properties: properties?.data ?? [])
                            } catch (let error) {
                                debugPrint(error.localizedDescription)
                            }
                        }
                        break
                    case .failure(let error):
                        self.myInsrancePresenter?.setLoading(isLoading: false)
                        debugPrint(error.localizedDescription)
                        break
                    }
                })
        }
        
    }
    
    func getShowAgainFlag() -> Bool? {
        return self.serviceFactory?.storage.fetch(key: "showAgain", type: Bool.self)
    }
    
    func fetchPinflList() {
        self.serviceFactory?
        .networkManager
        .user
        .request(.getPinflList, completion: { result in
            switch result {
            case .success(let response):
                
                do {
                    let decoder = JSONDecoder.init()
                    let pinflList = try decoder.decode(ArrayResponse<Pinfl>.self, from: response.data)
                    self.myInsrancePresenter?.setPinflList(list: pinflList.data ?? [])
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
                
                break
            case .failure(let error):
                debugPrint(error.localizedDescription)
                break
            }
        })
    }
}
