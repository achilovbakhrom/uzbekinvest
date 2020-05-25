//
//  MyInsuranceVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MyInsuranceVC: BaseViewImpl {
    
    private lazy var emptyView: EmptyView = EmptyView.fromNib()
    private lazy var myInsuranceView: MyInsuranceView = MyInsuranceView.fromNib()
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var myInsurancePresenter = self.presenter as? MyInsurancesPresenter
    
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
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
                self.reloadList()
            case .online(.wiFi):
                self.reloadList()
            }
        }
        
        self.reloadList()
        
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
            if !show {
                self.reloadList()
            }
        }
    }
    
    func reloadList() {
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.myInsurancePresenter?.fetchMyInsurances()
            break
        case .online(.wwan), .online(.wiFi):
            self.myInsurancePresenter?.fetchMyInsurances()
            break
        }
    }
    
    private func setupUI() {
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.onAdd = {
            self.myInsurancePresenter?.openAddInsurancePage()            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.setTabBarHidden(true)
            }
        }
        self.view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyView.topAnchor.constraint(equalTo: self.view.topAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
                
        myInsuranceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myInsuranceView)
        NSLayoutConstraint.activate([
            myInsuranceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myInsuranceView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myInsuranceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myInsuranceView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        myInsuranceView.isHidden = true
        myInsuranceView.onCategorySelected = {
            self.myInsurancePresenter?.categorySelected(category: $0)
        }
        myInsuranceView.onInsuranceClicked = { (item, property) in
            self.myInsurancePresenter?.insuranceSelected(myInsurance: item, property: property)
        }
        myInsuranceView.onAdd = {
            self.myInsurancePresenter?.openAddMyInsuranceVC()
        }
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        loadingView.isHidden = true
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            loadingView.startAnimating()
            loadingView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.loadingView.layer.opacity = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView.layer.opacity = 0.0
            }) { _ in
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
            }
        }
    }
    
    func setEmptyMode() {
        emptyView.isHidden = false
        myInsuranceView.isHidden = true
    }
    
    func setListingMode() {
        emptyView.isHidden = true
        myInsuranceView.isHidden = false
    }
    
    private func setupFirstTab() {
        let vc = self.tabBarController?.viewControllers?[0] as? UINavigationController
        
        while (vc?.viewControllers.count ?? 0 > 1) {
            vc?.popViewController(animated: false)
        }

    }
    
    func setMyInsurancesList(myInsurancesList: [MyInsurance], properties: [MyInsuranceProperties]) {
        myInsuranceView.data = myInsurancesList
        myInsuranceView.properties = properties
    }
    
    func setCategoryList(categoryList: [Category]) {
        myInsuranceView.categories = categoryList
    }
}
