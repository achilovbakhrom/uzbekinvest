//
//  InsuranceListVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class InsuranceListVC: BaseViewImpl {
    
    private lazy var insuranceListView: InsuranceListView = InsuranceListView.fromNib()
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    private lazy var myInsuranceListPresenter = self.presenter as? InsuranceListPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInsuranceListView()
        self.setupLoadingView()
        self.setupNoInternetView()
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.myInsuranceListPresenter?.fetchCategoryList()
            break
        }
    }
    
    private func setupInsuranceListView() {
        
        
        self.insuranceListView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(insuranceListView)
        NSLayoutConstraint.activate([
            self.insuranceListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.insuranceListView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.insuranceListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.insuranceListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.insuranceListView.setupUI()
        self.insuranceListView.onProductSelect = {
            self.myInsuranceListPresenter?.openInsurance(product: $0)
        }
        self.insuranceListView.onBack = {
            self.myInsuranceListPresenter?.goBack()
        }
    }
    
    private func setupNoInternetView() {
        self.view.addSubview(self.noInternetView)
        self.noInternetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noInternetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.noInternetView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noInternetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.noInternetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.view.bringSubviewToFront(self.noInternetView)
        self.noInternetView.layer.opacity = 0.0
        self.noInternetView.onRepeatClicked = {
            self.showNoInternetView(show: false)
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
            case .online(.wwan):
                self.myInsuranceListPresenter?.fetchCategoryList()
            case .online(.wiFi):
                self.myInsuranceListPresenter?.fetchCategoryList()
            }
        }
    }
    
    private func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setupLoadingView() {
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.view.bringSubviewToFront(self.loadingView)
    }
    
    func setCategories(categoryList: [Category]) {
        
        insuranceListView.categories = categoryList
    }
    
    func setProducts(productList: [Product]) {
        insuranceListView.products = productList
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
    }
    
}

