//
//  InsuranceListInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol InsuranceListInteractor: BaseInteractor {
    var assemblyFactory: AssemblyFactoryProtocol { get set }
    var serviceFactory: ServiceFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol, assembly: AssemblyFactoryProtocol, presenter: BasePresenter)
    func fetchCategoryList(showLoading: Bool)
}



class InsuranceListInteractorImpl: InsuranceListInteractor {
    
    var presenter: BasePresenter?
    var assemblyFactory: AssemblyFactoryProtocol
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var insuranceListPresenter = self.presenter as? InsuranceListPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, assembly: AssemblyFactoryProtocol, presenter: BasePresenter) {
        self.assemblyFactory = assembly
        self.serviceFactory = serviceFactory
        self.presenter = presenter
    }
    
    private func fetchProductList(showLoading: Bool) {
        self
            .serviceFactory
            .networkManager
            .product.request(.fetchAllProduct) { [unowned self] result in
                switch result {
                case .success(let res):
                    if showLoading {
                        self.insuranceListPresenter?.setLoading(isLoading: false)
                    }
                    let decoder = JSONDecoder()
                    do {
                        let json = try decoder.decode(ArrayResponse<Product>.self, from: res.data)
                        self.insuranceListPresenter?.setProductList(productList: json.data ?? [])
                    } catch(let error) {
                        self.insuranceListPresenter?.error(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.insuranceListPresenter?.error(msg: error.localizedDescription)
                    if showLoading {
                        self.insuranceListPresenter?.setLoading(isLoading: false)
                    }
                    break
                }
        }
    }
    
    func fetchCategoryList(showLoading: Bool = true) {
        if showLoading {
            self.insuranceListPresenter?.setLoading(isLoading: true)
        }
        self
            .serviceFactory
            .networkManager
            .others
            .request(.fetchCategoryList) { [unowned self] result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let r = try decoder.decode(ArrayResponse<Category>.self, from: response.data)
                        var categoryList = r.data ?? []
                        
                        var allCats = Category()
                        allCats.id = -1
                        allCats.translates = [
                            Translate(name: "Все", lang: "ru", text: nil, description: nil),
                            Translate(name: "Barcha bo'limlar", lang: "uz", text: nil, description: nil),
                            Translate(name: "Барча булимлар", lang: "oz", text: nil, description: nil)
                        ]
                        categoryList.insert(allCats, at: 0)
                        self.insuranceListPresenter?.setCategoryList(categoryList: categoryList)
                        self.fetchProductList(showLoading: showLoading)
                    } catch (let error) {
                        if showLoading { self.insuranceListPresenter?.setLoading(isLoading: false) }
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    if showLoading { self.insuranceListPresenter?.setLoading(isLoading: false) }
                    debugPrint(error.localizedDescription)
                    break
                }
        }
    }
    
}
