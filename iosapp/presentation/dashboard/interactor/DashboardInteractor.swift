//
//  DashboardInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol DashboardInteractor: BaseInteractor {
    var assemblyFactory: AssemblyFactoryProtocol { get set }
    var serviceFactory: ServiceFactoryProtocol { get set }
    init(serviceFactory: ServiceFactoryProtocol, assembly: AssemblyFactoryProtocol)
    func fetchCategoryList(showLoading: Bool)
    func fetchCarouselData()
    
}

class DashboardInteractorImpl: DashboardInteractor {
    var presenter: BasePresenter?
    var assemblyFactory: AssemblyFactoryProtocol
    var serviceFactory: ServiceFactoryProtocol
    
    private lazy var dashboardPresenter = self.presenter as? DashboardPresenter
    required init(serviceFactory: ServiceFactoryProtocol, assembly: AssemblyFactoryProtocol) {
        self.assemblyFactory = assembly
        self.serviceFactory = serviceFactory
    }
    
    private func fetchProductList(showLoading: Bool) {
        self
            .serviceFactory
            .networkManager
            .product.request(.fetchAllProduct) { [unowned self] result in
                switch result {
                case .success(let res):
                    if showLoading {
                        self.dashboardPresenter?.setLoading(isLoading: false)
                    }
                    let decoder = JSONDecoder()
                    do {
                        let json = try decoder.decode(ArrayResponse<Product>.self, from: res.data)
                        self.dashboardPresenter?.setProductList(productList: json.data ?? [])   
                    } catch(let error) {
                        self.dashboardPresenter?.error(msg: error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.dashboardPresenter?.error(msg: error.localizedDescription)
                    if showLoading {
                        self.dashboardPresenter?.setLoading(isLoading: false)
                    }
                    break
                }
        }
    }
    
    func fetchCategoryList(showLoading: Bool = true) {
        if showLoading {
            self.dashboardPresenter?.setLoading(isLoading: true)
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
                            Translate(name: "Все", lang: "", text: nil, description: nil),
                            Translate(name: "Barcha bo'limlar", lang: "", text: nil, description: nil),
                            Translate(name: "Барча булимлар", lang: "", text: nil, description: nil)
                        ]
                        categoryList.insert(allCats, at: 0)
                        self.dashboardPresenter?.setCategoryList(categoryList: categoryList)
                        self.fetchProductList(showLoading: showLoading)
                    } catch (let error) {
                        if showLoading { self.dashboardPresenter?.setLoading(isLoading: false) }
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    if showLoading { self.dashboardPresenter?.setLoading(isLoading: false) }
                    debugPrint(error.localizedDescription)
                    break
                }
        }
        
    }
    
    func fetchCarouselData() {
        self.dashboardPresenter?.setCarouselLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .others
            .request(.fetchCarouselData) { result in
                switch result {
                case .success(let response):
                    self.dashboardPresenter?.setCarouselLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder()
                        let r = try decoder.decode(ArrayResponse<Carousel>.self, from: response.data)
                        self.dashboardPresenter?.setCarouselList(carouselList: r.data ?? [])
                    } catch (let error) {
                        debugPrint(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    self.dashboardPresenter?.setCarouselLoading(isLoading: false)
                    debugPrint(error.localizedDescription)
                    break
                }
            }
        
    }
}
