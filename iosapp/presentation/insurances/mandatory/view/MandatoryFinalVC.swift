//
//  MandatoryFinalVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/31/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MandatoryFinalVC: BaseInsuranceConfirmVC {
    
//    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        backButtonClick = { self.mandatoryPresenter?.goBack() }
//        self.setupUI()
//        self.mandatoryPresenter?.fillFinalVC()
//        imagePickerManager.customGalleryClicked = {
//            self.dismiss(animated: true) {
//                self.navigationController?.pushViewController(self.customImagePicker, animated: true)
//            }
//        }
//        self.confirmButton.addTarget(self, action: #selector(onConfirmClick(_:)), for: .touchUpInside)
//        customImagePicker.onFileSelected = { uf in
//            var i = 0
//            self.documents.forEach { d in
//                if let doc = uf.document, d.id == doc.id {
//                     return
//                } else {
//                    i += 1
//                }
//            }
//            if i < self.documentFiles.count {
//                let v = self.documentFiles[i]
//                v.mode = .info
//                v.isStatusChecked = true
//                v.contentLabel.text = uf.name
//            }
//        }
//    }
//
//    @objc
//    private func onConfirmClick(_ sender: Any) {
//        print("confirm clicked")
//    }
//
//    private func setupUI() {
////        self.addressView.onChnageButtonClicked = { print("onAddress change") }
//    }
//
//    override func onDateSelected(date: Date) {
//
//    }
//
//    override func onPaymentTypeSelected(seq: Int) {
//
//    }
//
//    override func onLongLatSelected(long: Double, lat: Double) {
//
//    }
//
//    func setName(name: String) {
//        self.titleLabel.text = name
//    }
//
//    func setAmount(amount: String) {
//        paymentLabel.text = amount
//    }
//
//    func setAddress(address: String) {
//        self.addressView.contentLabel.text = address
//    }
//
//    func setStartDate(startDate: String) {
//        self.startDateView.contentLabel.text = startDate
//    }
//
//    func setUserFilesLoading(isLoading: Bool) {
//        self.customImagePicker.setLoading(isLoading: isLoading)
//    }
//
//    func setUserFiles(userFiles: [UserFile]) {
//        imagePickerManager.isCustomGallery = !userFiles.isEmpty
//        customImagePicker.files = userFiles
//    }
//
//    var documentFiles = [PropertyRowView]()
//    var documents = [Document]()
//    func setDocuments(documents: [Document]) {
//        self.documents = documents
//        var index = 0
//        documents.forEach { document in
//
//            let v = PropertyRowView(frame: .zero)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            v.onChnageButtonClicked = {
//                self.imagePickerManager.pickImage(self) { (image, path) in
//                    var i = 0
//                    documents.forEach {
//                        if $0.id == document.id {
//                            return
//                        } else {
//                            i += 1
//                        }
//                    }
//                    self.documentFiles[i].mode = .info
//                    self.documentFiles[i].isStatusChecked = true
//                    self.documentFiles[i].contentLabel.text = path
//                    let fileName = URL(string: path)?.lastPathComponent ?? "unkown"
//                    self.mandatoryPresenter?.uploadFile(data: image.pngData()!, documentId: document.id, name: fileName)
//                }
//            }
//            v.onUploadButtonClicked = {
//                self.imagePickerManager.pickImage(self) { (image, path) in
//                    var i = 0
//                    documents.forEach {
//                        if $0.id == document.id {
//                            return
//                        } else {
//                            i += 1
//                        }
//                    }
//                    self.documentFiles[i].mode = .info
//                    self.documentFiles[i].isStatusChecked = true
//                    self.documentFiles[i].contentLabel.text = path
//                    let fileName = URL(string: path)?.lastPathComponent ?? "unkown"
//                    self.mandatoryPresenter?.uploadFile(data: image.pngData()!, documentId: document.id, name: fileName)
//                }
//            }
//            v.titleLabel.text = document.translates?[0]?.name
//            let files = self.customImagePicker.files
//            var found: UserFile? = nil
//            files.forEach {
//                if let d = $0.document, d.id == document.id {
//                    found = $0
//                    return
//                }
//            }
//
//            if let f = found {
//                v.contentLabel.text = f.name
//                v.mode = .doc
//            } else {
//                v.mode = .upload
//            }
//
//            self.propertiesView.addSubview(v)
//            if index == 0 {
//                NSLayoutConstraint.activate([
//                    v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//                    v.topAnchor.constraint(equalTo: self.propertiesView.topAnchor),
//                    v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
//                ])
//
//            } else if index == documents.count - 1 {
//                let prev = documentFiles[index - 1]
//                NSLayoutConstraint.activate([
//                    v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//                    v.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 1),
//                    v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
//                ])
//            } else {
//                let prev = documentFiles[index - 1]
//                NSLayoutConstraint.activate([
//                    v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//                    v.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 1),
//                    v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
//                ])
//            }
//            let div = createDivider()
//            self.propertiesView.addSubview(div)
//            NSLayoutConstraint.activate([
//                div.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
//                div.topAnchor.constraint(equalTo: v.bottomAnchor),
//                div.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
//                div.heightAnchor.constraint(equalToConstant: 1.0)
//            ])
//
//            if index == documents.count - 1 {
//                div.bottomAnchor.constraint(equalTo: self.propertiesView.bottomAnchor).isActive = true
//            }
//
//            self.documentFiles.append(v)
//            index += 1
//        }
//    }
//
    
}
