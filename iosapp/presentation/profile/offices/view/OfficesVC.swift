//
//  OfficesVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class OfficesVC: BaseViewImpl {
    
    private lazy var officesView: OfficesView = OfficesView.fromNib()
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var officesPresenter = self.presenter as? OfficesPresenter
    
    private var pagerVC: OfficesViewPagerVC!
    
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(officesView)
        NSLayoutConstraint.activate([
            self.officesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.officesView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.officesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.officesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.officesView.onBackClicked = {
            self.officesPresenter?.goBack()
        }
        pagerVC = OfficesViewPagerVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pagerVC.onPageChanged = { page in
            self.officesView.setMode(isListMode: page == 0)
        }
        self.addChild(pagerVC)
        self.officesView.contentView.addSubview(pagerVC.view)
        NSLayoutConstraint.activate([
            pagerVC.view.leadingAnchor.constraint(equalTo: self.officesView.contentView.leadingAnchor),
            pagerVC.view.topAnchor.constraint(equalTo: self.officesView.contentView.topAnchor),
            pagerVC.view.trailingAnchor.constraint(equalTo: self.officesView.contentView.trailingAnchor),
            pagerVC.view.bottomAnchor.constraint(equalTo: self.officesView.contentView.bottomAnchor)
        ])
        self.officesView.onModeChanged = { isListMode in
            if isListMode {
                self.pagerVC.goToPrevPage()
            } else {
                self.pagerVC.goToNextPage()
            }
        }
        
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.setupNoInternetView()
        self.officesView.setMode(isListMode: true)
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.officesPresenter?.fetchOfficesList()
            break
        }
    }
    
    func setupNoInternetView() {
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
                self.officesPresenter?.fetchOfficesList()
            case .online(.wiFi):
                self.officesPresenter?.fetchOfficesList()
            }
        }
        
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setOfficesList(officesList: Array<Office>) {
        self.pagerVC.setOfficesList(officesList: officesList)
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
