//
//  IncidentFilesVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentFilesVC: BaseWithLeftCirclesVC {
    
    private lazy var filesView: IncidentFilesView = IncidentFilesView.fromNib()
    
    private var incidentsPresenter: IncidentsAddEditPresenter? {
        get {
            return self.presenter as? IncidentsAddEditPresenter
        }
    }
    
    private lazy var imagePickerManager: ImagePickerManager = {
        let manager = ImagePickerManager()
        manager.isCustomGallery = false
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(filesView)
        filesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.filesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.filesView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 20),
            self.filesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.filesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        filesView.onAddClicked = {
            self.imagePickerManager.pickImage(self) { image, name in
                self.filesView.files.append(name)
                UIView.transition(with: self.filesView.filesTableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self.filesView.filesTableView.reloadData()
                }) { _ in
                    self.incidentsPresenter?.addFile(name: name, data: image.pngData()!)
                }
            }
        }
        
        self.backButtonClicked = {
            self.incidentsPresenter?.goBack()
        }
        
        filesView.onDelete = {
            self.incidentsPresenter?.removeFile(index: $0)
        }
        
        filesView.onNext = {
            self.incidentsPresenter?.createIncidentFromFilesVC()
        }
    }
}
