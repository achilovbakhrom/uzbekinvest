//
//  MyDocumentsVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.

import UIKit

class MyDocumentsVC: BaseViewImpl {
    
    let myDocumentsView: MyDocumentsView = MyDocumentsView.fromNib()
    let loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    private lazy var myDocumentsPresenter = self.presenter as? MyDocumentsPrsenter
    lazy var imagePickerManager: ImagePickerManager = ImagePickerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false        
        myDocumentsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myDocumentsView)
        NSLayoutConstraint.activate([
            self.myDocumentsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.myDocumentsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.myDocumentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.myDocumentsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        loadingView.layer.opacity = 0.0
        
        myDocumentsView.onBack = {
            self.myDocumentsPresenter?.goBack()
        }
        myDocumentsView.onRemove = {
            self.myDocumentsPresenter?.removeFile(id: $0)
        }
        myDocumentsView.onUpload = { docId in
            self.imagePickerManager.isCustomGallery = false
            self.imagePickerManager.pickImage(self) { (image, path) in
                let fileName = URL(string: path)?.lastPathComponent ?? "unknown"
                self.myDocumentsPresenter?.uploadFile(data: image.pngData()!, documentId: docId, name: fileName)
            }
        }
        self.setTabBarHidden(true)
        self.setupNoInternetView()
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.myDocumentsPresenter?.loadDocuments()
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
                self.myDocumentsPresenter?.loadDocuments()
            case .online(.wiFi):
                self.myDocumentsPresenter?.loadDocuments()
            }
        }
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setTabBarHidden(false)
    }
    
    func setLoading(isLoading: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
    }
    
    func setDocuments(documents: [Document]) {
        self.myDocumentsView.documents = documents
    }
    
    
    func setUserFiles(userFiles: [UserFile]) {
        self.myDocumentsView.userFiles = userFiles
    }
}
