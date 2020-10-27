//
//  PinflVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class PinflVC: BaseViewImpl {
    lazy var pinflView: PinflView = PinflView.fromNib()
    private lazy var settingsPresenter = self.presenter as? SettingsPresenter
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pinflView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pinflView)
        NSLayoutConstraint.activate([
            self.pinflView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pinflView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.pinflView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pinflView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.pinflView.onRemove = { id in
            let ac = UIAlertController(title: "remove_pinfl".localized(), message: "remove_pinfl_msg".localized(), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "yes".localized(), style: .destructive, handler: { _ in
                self.settingsPresenter?.removePinfl(pinfl: id)
            }))
            ac.addAction(UIAlertAction(title: "no".localized(), style: .cancel, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
        self.pinflView.onAdd = {
            self.settingsPresenter?.openAddByPinfl()
        }
        self.pinflView.onBack = {
            self.settingsPresenter?.goBack()
        }
        self.setupNoInternetView()
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.settingsPresenter?.fetchPinflList()
            break
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUpdateSignal(_:)), name: Notification.Name("updatePinfl"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let f = self.tabBarController?.tabBar.frame {
            let screenHeight = UIScreen.main.bounds.height
            if f.height < screenHeight {
                self.tabBarController?.tabBar.frame = CGRect(x: f.origin.x, y: screenHeight, width: f.width, height: f.height)
            }
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
                self.settingsPresenter?.fetchPinflList()
            case .online(.wiFi):
                self.settingsPresenter?.fetchPinflList()
            }
        }
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setLoading(isLoading: Bool) {
        self.pinflView.addButton.isLoading = isLoading
    }
    
    @objc
    private func didReceiveUpdateSignal(_ notification:Notification) {
        self.settingsPresenter?.fetchPinflList()
    }
    
    func setPinflList(list: [Pinfl]) {
        pinflView.pinflList = list
    }
    
}
