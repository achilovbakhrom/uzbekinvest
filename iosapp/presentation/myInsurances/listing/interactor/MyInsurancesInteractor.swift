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
                    self.myInsrancePresenter?.setCategoryList(categoryList: categoryList)
                    didLoad(true)
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
    
    func fetchMyInsurances() {
        self.myInsrancePresenter?.setLoading(isLoading: true)
        fetchCategoryList { [unowned self] _ in
            self.serviceFactory?.networkManager
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
    
}
