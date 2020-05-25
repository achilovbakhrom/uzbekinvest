//
//  AddMyInsuranceVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class AddMyInsuranceVC: BaseViewImpl {
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back-arrow"), for: .normal)
        return button
    }()
    
    private lazy var emptyView: EmptyView = EmptyView.fromNib()
    private lazy var myInsurancePresenter = self.presenter as? MyInsurancesPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        var topMagin: CGFloat = 0.0
        if isIPhone4OrNewer() {
            topMagin = 20
        } else if isIPhoneSE() {
            topMagin = 30
        } else if isIPhonePlus() {
            topMagin = 40
        } else {
            topMagin = 65
        }
        
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            self.backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31),
            self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topMagin),
            self.backButton.widthAnchor.constraint(equalToConstant: 25),
            self.backButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        self.backButton.addTarget(self, action: #selector(onBackAction(_:)), for: .touchUpInside)
        var contentTopMagin: CGFloat = 0.0
        if isIPhone4OrNewer() {
            contentTopMagin = 0
        } else if isIPhoneSE() {
            contentTopMagin = 0
        } else if isIPhonePlus() {
            contentTopMagin = 40
        } else {
            contentTopMagin = 65
        }
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            self.emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.emptyView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: contentTopMagin),
            self.emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.emptyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        emptyView.onAdd = {
            self.myInsurancePresenter?.openAddInsurancePage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.setTabBarHidden(true)
            }
        }
        emptyView.onBuy = {}
    }
    
    @objc
    private func onBackAction(_ sender: Any) {
        self.myInsurancePresenter?.goBack()
    }
}
