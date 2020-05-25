//
//  MainProfileVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MainProfileVC: BaseViewImpl {
    
    private lazy var mainProfileView: MainProfileView = MainProfileView.fromNib()
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var mainProfilePresenter = self.presenter as? MainProfilePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainProfileView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainProfileView)
        NSLayoutConstraint.activate([
            self.mainProfileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainProfileView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mainProfileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mainProfileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.mainProfileView.onBranchesList = {
            self.mainProfilePresenter?.openOfficesVC()
        }
        
        self.mainProfileView.onMyDocs = {
            self.mainProfilePresenter?.openMyDocs()
        }
        
        self.mainProfileView.onSettings = {
            self.mainProfilePresenter?.openSettings()
        }
        
        self.view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.mainProfilePresenter?.fetchMe()
    }
    
    func reloadData() {
        self.mainProfilePresenter?.fetchMe()
    }
    
    func setUser(user: ProfileUser?) {
        self.mainProfileView.username?.text = user?.name
        self.mainProfileView.withUsLabel?.text = "\(user?.daysActive ?? 0)"
        self.mainProfileView.myPolicesLabel?.text = "\(user?.completedOrders ?? 0)"
        self.mainProfileView.incidentsLabel?.text = "\(user?.incidents ?? 0)"
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.4) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
    }
    
}

