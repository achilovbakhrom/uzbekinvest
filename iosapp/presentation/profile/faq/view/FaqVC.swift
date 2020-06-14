//
//  FaqVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class FaqVC: BaseViewImpl {
    
    let faqView: FaqView = FaqView.fromNib()
    let loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var faqPresenter = self.presenter as? FaqPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faqView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(faqView)
        NSLayoutConstraint.activate([
            self.faqView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.faqView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.faqView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.faqView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.faqView.onBack = { self.faqPresenter?.goBack() }        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.loadingView.layer.opacity = 0.0
        self.setTabBarHidden(true)
        
        self.faqPresenter?.fetchFaqList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading  ? 1.0 : 0.0
        }
    }
    
    func setFaqList(list: [Question]) {
        self.faqView.setFaqList(faqList: list)
    }
    
}
