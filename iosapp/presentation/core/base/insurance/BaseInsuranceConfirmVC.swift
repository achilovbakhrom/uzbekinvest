//
//  BaseInsuranceConfirmVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import LocationPicker
import CoreLocation
import DatePickerDialog

class BaseInsuranceConfirmVC: BaseViewImpl, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    var backButtonClick: (() -> Void)? = nil
    private var selected = 0
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "back-arrow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var confirmButton: Button = {
        let button = Button(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("checkout".localized(), for: .normal)
        return button
    }()
    
    lazy var propertiesView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var confirmTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textColor = UIColor.white
        label.text = "checkout".localized()
        return label
    }()
    
    lazy var paymentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 \("sum".localized())"
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        return label
    }()
    
    lazy var addressView: PropertyRowView = {
        let view = PropertyRowView()
        view.titleLabel.text = "delivery_region".localized()
        view.mode = .info
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentLabel.text = "-"
        view.isStatusChecked = true
        return view
    }()
    
    lazy var startDateView: PropertyRowView = {
        let view = PropertyRowView()
        view.titleLabel.text = "policy_begin_time".localized()
        view.isStatusChecked = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentLabel.text = "02.02.2020"
        view.mode = .info
        return view
    }()
    
    private lazy var paymentTypesList: [PaymentTypeCellModel] = {
        return [
            PaymentTypeCellModel(icon: "online-pay", title: "online_pay".localized(), selected: false, isFirst: true),
            PaymentTypeCellModel(icon: "cash-pay", title: "cash_pay".localized(), selected: false, isFirst: false),
            PaymentTypeCellModel(icon: "card-pay", title: "terminal_pay".localized(), selected: false, isFirst: false),
        ]
    }()
    
    lazy var locationPicker: LocationPickerViewController = {
        let locationPicker =  LocationPickerViewController()
        
        locationPicker.showCurrentLocationButton = true // default: true
        locationPicker.currentLocationButtonBackground = .white
        locationPicker.showCurrentLocationInitially = true // default: true
        locationPicker.mapType = .standard
        locationPicker.searchBarStyle = .default
        locationPicker.useCurrentLocationAsHint = true // default: false
        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"
        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"
        // optional region distance to be used for creation region when user selects place from search results
        locationPicker.resultRegionDistance = 800 // default: 600
        locationPicker.onClose = {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        return locationPicker
    }()
    
    lazy var customImagePicker: UserFilesPicker = {
        let fp = UserFilesPicker()
        return fp
    }()
    
    lazy var imagePickerManager: ImagePickerManager = ImagePickerManager()
    
    let locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        return lm
    }()
    
    var documentFiles = [Int: PropertyRowView]()
    var secondaryDocumentFiles: [Int: [Int: PropertyRowView]]? = nil
    var userFiles: [UserFile] = []
    var regions: [Region] = []
    var collectionView: UICollectionView!
    
    private lazy var insurancePresenter = self.presenter as? BaseInsurancePresenter
    
    func setInsuranceName(name: String) {
        self.titleLabel.text = name
    }
    
    func setInsuranceAmount(amount: String) {
        self.paymentLabel.text = amount
    }
    
    func setUserFiles(userFiles: [UserFile]) {
        self.userFiles = userFiles
    }
    
    func setup(totalAmount: String, documents: [Document], secondary: [Document], userFiles: [UserFile], membersCount: Int) {
        self.userFiles = userFiles
        self.paymentLabel.text = totalAmount
        var index = 0
        var lastDiv: UIView? = nil
        var lastDocument: Document!
        self.imagePickerManager.customGalleryClicked = {
            self.dismiss(animated: true) {
                self.present(self.customImagePicker, animated: true, completion: nil)
            }
        }
        
        documents.forEach { document in
             
            let v = PropertyRowView(frame: .zero)
            v.translatesAutoresizingMaskIntoConstraints = false
            v.onChnageButtonClicked = {
                let docFiles = self.userFiles.filter({ uf -> Bool in
                    return uf.document?.id == document.id
                });
                self.customImagePicker.files = docFiles;
                self.customImagePicker.onFileSelected = {
                    v.mode = .info
                    v.isStatusChecked = true
                    v.contentLabel.text = $0.name
                    self.insurancePresenter?.setMainDocument(documentId: document.id, file: $0)
                    self.dismiss(animated: true, completion: nil)
                }
                self.imagePickerManager.isCustomGallery = docFiles.count > 0
                self.imagePickerManager.pickImage(self) { (image, path) in
                    v.mode = .info
                    v.isStatusChecked = true
                    v.contentLabel.text = path
                    let fileName = URL(string: path)?.lastPathComponent ?? "unknown"
                    self.insurancePresenter?.uploadFile(data: image.pngData()!, documentId: document.id, name: fileName, isMain: true)
                }
            }
            
            v.onUploadButtonClicked = {
                let docFiles = self.userFiles.filter({ uf -> Bool in
                    return uf.document?.id == document.id
                });
                self.customImagePicker.files = docFiles;
                self.customImagePicker.onFileSelected = {
                    v.mode = .info
                    v.isStatusChecked = true
                    v.contentLabel.text = $0.name
                    self.insurancePresenter?.setMainDocument(documentId: document.id, file: $0)
                    self.dismiss(animated: true, completion: nil)
                }
                self.imagePickerManager.isCustomGallery = docFiles.count > 0
                self.imagePickerManager.pickImage(self) { (image, path) in
                    v.mode = .info
                    v.isStatusChecked = true
                    v.contentLabel.text = path
                    let fileName = URL(string: path)?.lastPathComponent ?? "unknown"
                    self.insurancePresenter?.uploadFile(data: image.pngData()!, documentId: document.id, name: fileName, isMain: true)
                }
            }
            
            v.titleLabel.text = document.translates?[0]?.name
            
            var found: UserFile? = nil
            
            self.userFiles.forEach {
                if let d = $0.document, d.id == document.id {
                    found = $0
                    return
                }
            }
            
            if let f = found {
                v.contentLabel.text = f.name
                self.insurancePresenter?.setMainDocument(documentId: document.id, file: f)
                v.mode = .doc
                v.isStatusChecked = true
            } else {
                v.mode = .upload
                v.isStatusChecked = false
            }
            
            self.propertiesView.addSubview(v)
            if index == 0 {
                NSLayoutConstraint.activate([
                    v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                    v.topAnchor.constraint(equalTo: self.propertiesView.topAnchor),
                    v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                ])
                
            } else if index == documents.count - 1 {
                let prev = documentFiles[lastDocument.id]!
                NSLayoutConstraint.activate([
                    v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                    v.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 1),
                    v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                ])
            } else {
                let prev = documentFiles[lastDocument.id]!
                NSLayoutConstraint.activate([
                    v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                    v.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 1),
                    v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                ])
            }
            let div = createDivider()
            self.propertiesView.addSubview(div)
            NSLayoutConstraint.activate([
                div.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                div.topAnchor.constraint(equalTo: v.bottomAnchor),
                div.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
                div.heightAnchor.constraint(equalToConstant: 1.0)
            ])
            
            if index == documents.count - 1 && membersCount == 0 {
                div.bottomAnchor.constraint(equalTo: self.propertiesView.bottomAnchor).isActive = true
            } else if index == documents.count - 1 && membersCount > 0 {
                lastDiv = div
            }
            self.documentFiles[document.id] = v
            lastDocument = document
            index += 1
        }
        
        if membersCount > 0 {
            self.secondaryDocumentFiles = [:]
            var lastElement: UIView? = nil
            var lastSecondaryDocument: Document!
            
            (0..<membersCount).forEach { i in
                let header = createHeader(number: i+1, contentView: self.propertiesView, lastElement: i == 0  ? lastDiv! : lastElement!)
                index = 0
                secondary.forEach { document in
                     
                    let v = PropertyRowView(frame: .zero)
                    v.translatesAutoresizingMaskIntoConstraints = false
                    v.onChnageButtonClicked = {
                        let docFiles = self.userFiles.filter({ uf -> Bool in
                            return uf.document?.id == document.id
                        });
                        self.customImagePicker.files = docFiles;
                        self.customImagePicker.onFileSelected = {
                            v.mode = .info
                            v.isStatusChecked = true
                            v.contentLabel.text = $0.name
                            self.insurancePresenter?.setSecondaryDocument(sequence: i, documentId: document.id, userFile: $0)
                            self.dismiss(animated: true, completion: nil)
                        }
                        self.imagePickerManager.isCustomGallery = docFiles.count > 0
                        self.imagePickerManager.pickImage(self) { (image, path) in
                            v.mode = .info
                            v.isStatusChecked = true
                            v.contentLabel.text = path
                            let fileName = URL(string: path)?.lastPathComponent ?? "unknown"
                            self.insurancePresenter?.uploadFile(data: image.pngData()!, documentId: document.id, name: fileName, isMain: false, sequence: i)
                        }
                    }
                    v.onUploadButtonClicked = {
                        let docFiles = self.userFiles.filter({ uf -> Bool in
                            return uf.document?.id == document.id
                        });
                        self.customImagePicker.files = docFiles;
                        self.customImagePicker.onFileSelected = {
                            v.mode = .info
                            v.isStatusChecked = true
                            v.contentLabel.text = $0.name
                            self.insurancePresenter?.setSecondaryDocument(sequence: i, documentId: document.id, userFile: $0)
                            self.dismiss(animated: true, completion: nil)
                        }
                        self.imagePickerManager.isCustomGallery = docFiles.count > 0
                        self.imagePickerManager.pickImage(self) { (image, path) in
                            v.mode = .info
                            v.isStatusChecked = true
                            v.contentLabel.text = path
                            let fileName = URL(string: path)?.lastPathComponent ?? "unknown"
                            self.insurancePresenter?.uploadFile(data: image.pngData()!, documentId: document.id, name: fileName, isMain: false, sequence: i)
                        }
                    }
                    v.titleLabel.text = document.translates?[0]?.name
                    
                    var found: UserFile? = nil
                    
                    self.userFiles.forEach {
                        if let d = $0.document, d.id == document.id {
                            found = $0
                            return
                        }
                    }
                    
                    if let f = found {
                        v.contentLabel.text = f.name
                        v.mode = .doc
                        v.isStatusChecked = true
                        self.insurancePresenter?.setSecondaryDocument(sequence: i, documentId: document.id, userFile: f)
                    } else {
                        v.mode = .upload
                        v.isStatusChecked = false
                    }
                    
                    self.propertiesView.addSubview(v)
                    
                    if i == 0 && index == 0{
                        NSLayoutConstraint.activate([
                            v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                            v.topAnchor.constraint(equalTo: header.bottomAnchor),
                            v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                        ])
                    } else {
                        var prev: UIView? = nil
                        if index == 0 {
                            prev = header
                        } else {
                            prev = self.secondaryDocumentFiles![i]![lastSecondaryDocument.id]!
                        }
                        NSLayoutConstraint.activate([
                            v.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                            v.topAnchor.constraint(equalTo: prev!.bottomAnchor, constant: 1),
                            v.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor)
                        ])
                    }
                    let div = createDivider()
                    self.propertiesView.addSubview(div)
                    NSLayoutConstraint.activate([
                        div.leadingAnchor.constraint(equalTo: self.propertiesView.leadingAnchor),
                        div.topAnchor.constraint(equalTo: v.bottomAnchor),
                        div.trailingAnchor.constraint(equalTo: self.propertiesView.trailingAnchor),
                        div.heightAnchor.constraint(equalToConstant: 1.0)
                    ])
                    
                    if index == secondary.count - 1 && i == membersCount-1 {
                        div.bottomAnchor.constraint(equalTo: self.propertiesView.bottomAnchor).isActive = true
                    } else {
                        lastElement = v
                    }
                    let pair = [document.id: v]
                    self.secondaryDocumentFiles?[i] = pair
                    lastSecondaryDocument = document
                    index += 1
                }
            }
        }
    }
    
    func setRegions(regions: [Region]) {
        self.regions = regions
        self.addressView.changeButton.isEnabled = self.regions.count > 0
        if regions.count > 0 {
            let r = regions[0]
            if (r.children ?? []).isEmpty {
                self.addressView.contentLabel.text = regions[0].name
            } else {
                self.addressView.contentLabel.text = r.children?[0]?.name
            }
                        
        }
    }
    
    func setMainDocumentName(documentId: Int, name: String) {
        self.documentFiles[documentId]?.contentLabel.text = name
    }
    
    func setSecondaryDocumentName(sequence: Int, documentId: Int, name: String) {
        self.secondaryDocumentFiles?[sequence]?[documentId]?.contentLabel.text = name
    }
    
    @objc
    private func createInsurance() {
        self.insurancePresenter?.confirmButtonClicked()
    }
    
    func setUploading(isUploading: Bool) {
        self.confirmButton.isLoading = isUploading
        if isUploading {
            self.confirmButton.setTitle("\("loading_confirm".localized())...", for: .normal)
        } else {
            self.confirmButton.setTitle("confirm_button".localized(), for: .normal)
        }
    }
    
    private func createHeader(number: Int, contentView: UIView, lastElement: UIView) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: lastElement.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        label.text = "No. \(number)"
        return view
    }
    
    private var popover: LCPopover<Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.setupUI()
//        self.locationManager.delegate = self
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        } else {
//            self.locationManager.requestWhenInUseAuthorization()
//        }
        
        self.addressView.onChnageButtonClicked = {
            
            let regionList: [LCTuple<Int>] = self.regions.map { (key: $0.id, value: $0.name) }
            self.popover = LCPopover<Int>(for: self.addressView.changeButton, title: "delivery_region".localized()) { tuple in
                guard let key = tuple?.key else { return }
                guard let value = tuple?.value else { return }
                
                let selectedRegion = self.regions.first { $0.id == key }
                if selectedRegion?.children != nil && !(selectedRegion?.children?.isEmpty ?? false) {
                    
                    self.popover = LCPopover<Int>(for: self.addressView.changeButton, title: "delivery_region".localized()) { tuple in
                        guard let key = tuple?.key else { return }
                        guard let value = tuple?.value else { return }
                        self.addressView.contentLabel.text = value
                        self.insurancePresenter?.setRegionId(regionId: key)
                    }
                    self.popover.backgroundColor = Colors.primaryGreen
                    self.popover.borderWidth = 0.0
                    self.popover.barHeight = 0.0
                    self.popover.titleColor = Colors.primaryGreen
                    self.popover.dataList = (selectedRegion?.children ?? []).map { c in
                        return (key: c?.id ?? 0, value: c?.name ?? "" )
                    }
                    self.present(self.popover, animated: true, completion: nil)
                } else {
                    self.addressView.contentLabel.text = value
                    self.insurancePresenter?.setRegionId(regionId: key)
                }
            }
            self.popover.backgroundColor = Colors.primaryGreen
            self.popover.borderWidth = 0.0
            self.popover.barHeight = 0.0
            self.popover.titleColor = Colors.primaryGreen
            self.popover.dataList = regionList
            self.present(self.popover, animated: true, completion: nil)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let d = formatter.string(from: Date())
        self.insurancePresenter?.setStartDate(startDate: d)
        self.startDateView.contentLabel.text = d
        
        self.startDateView.onChnageButtonClicked = {
            DatePickerDialog().show("begin_period".localized(), doneButtonTitle: "ОК", cancelButtonTitle: "cancel".localized(), datePickerMode: .date) {
                (date) -> Void in
                if let dt = date {
                    self.onDateSelected(date: dt)
                }
            }
        }
        backButtonClick = { self.insurancePresenter?.goBack() }
        self.addressView.changeButton.isEnabled = false
        self.insurancePresenter?.setupFinalVC()
    }
    
    func onDateSelected(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let d = formatter.string(from: date)
        self.insurancePresenter?.setStartDate(startDate: d)
        self.startDateView.contentLabel.text = d
    }
    
    func onLongLatSelected(long: Double, lat: Double) {
        
    }
    
    
    private func setupUI() {
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
        
        self.scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.height),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
        
        self.contentView.addSubview(backButton)
        NSLayoutConstraint.activate([
            self.backButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.backButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40)
        ])
        
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.titleLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 29),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        self.contentView.addSubview(confirmTitle)
        NSLayoutConstraint.activate([
            self.confirmTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40),
            self.confirmTitle.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 27)
        ])
        
        let confirmTitleContainer = UIView(frame: .zero)
        confirmTitleContainer.translatesAutoresizingMaskIntoConstraints = false
        confirmTitleContainer.backgroundColor = UIColor.init(red: 77.0/255.0, green: 207.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        self.contentView.addSubview(confirmTitleContainer)
        NSLayoutConstraint.activate([
            confirmTitleContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            confirmTitleContainer.centerYAnchor.constraint(equalTo: self.confirmTitle.centerYAnchor),
            confirmTitleContainer.trailingAnchor.constraint(equalTo: self.confirmTitle.trailingAnchor, constant: 9),
            confirmTitleContainer.heightAnchor.constraint(equalToConstant: 27)
        ])
        confirmTitleContainer.layer.cornerRadius = 13.5
        confirmTitleContainer.layer.masksToBounds = true
        
        self.contentView.bringSubviewToFront(self.confirmTitle)
        
        let divider = createDivider()
        self.contentView.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            divider.topAnchor.constraint(equalTo: confirmTitleContainer.bottomAnchor, constant: 28),
            divider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        let paymentTitle = UILabel(frame: .zero)
        paymentTitle.text = "to_pay".localized()
        paymentTitle.font = UIFont.init(name: "Roboto-Regular", size: 14)
        paymentTitle.textColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 0.5)
        paymentTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(paymentTitle)
        NSLayoutConstraint.activate([
            paymentTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            paymentTitle.topAnchor.constraint(equalTo: divider.topAnchor, constant: 28)
        ])
        
        self.contentView.addSubview(self.paymentLabel)
        NSLayoutConstraint.activate([
            self.paymentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.paymentLabel.topAnchor.constraint(equalTo: paymentTitle.bottomAnchor, constant: 14),
            self.paymentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 31)
        ])

        let topCheckImageView = UIImageView(image: UIImage(named: "check-mark"))
        topCheckImageView.translatesAutoresizingMaskIntoConstraints = false
        topCheckImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(topCheckImageView)
        NSLayoutConstraint.activate([
            topCheckImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31.0),
            topCheckImageView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 32.0),
            topCheckImageView.heightAnchor.constraint(equalToConstant: 32.0),
            topCheckImageView.widthAnchor.constraint(equalToConstant: 32.0),
        ])

        let paymentTypeTitle = UILabel(frame: .zero)
        paymentTypeTitle.translatesAutoresizingMaskIntoConstraints = false
        paymentTypeTitle.text = "form_of_pay".localized()
        paymentTypeTitle.font = UIFont.init(name: "Roboto-Regular", size: 14)
        paymentTypeTitle.textColor = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 0.5)
        self.contentView.addSubview(paymentTypeTitle)
        NSLayoutConstraint.activate([
            paymentTypeTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31.0),
            paymentTypeTitle.topAnchor.constraint(equalTo: self.paymentLabel.bottomAnchor, constant: 29.0)
        ])

        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PaymentTypeCell.self, forCellWithReuseIdentifier: String(describing: PaymentTypeCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        self.contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: paymentTypeTitle.bottomAnchor, constant: 14),
            collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        let divider2 = createDivider()
        self.contentView.addSubview(divider2)
        NSLayoutConstraint.activate([
            divider2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            divider2.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 33),
            divider2.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        self.contentView.addSubview(self.addressView)
        NSLayoutConstraint.activate([
            addressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            addressView.topAnchor.constraint(equalTo: divider2.bottomAnchor),
            addressView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        let divider3 = createDivider()
        self.contentView.addSubview(divider3)
        NSLayoutConstraint.activate([
            divider3.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            divider3.topAnchor.constraint(equalTo: self.addressView.bottomAnchor),
            divider3.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            divider3.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        self.contentView.addSubview(self.startDateView)
        NSLayoutConstraint.activate([
            startDateView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            startDateView.topAnchor.constraint(equalTo: divider3.bottomAnchor),
            startDateView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])

        let divider4 = createDivider()
        self.contentView.addSubview(divider4)
        NSLayoutConstraint.activate([
            divider4.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            divider4.topAnchor.constraint(equalTo: self.startDateView.bottomAnchor),
            divider4.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            divider4.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        self.contentView.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            self.confirmButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.confirmButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.confirmButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -31),
            self.confirmButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        self.confirmButton.addTarget(self, action: #selector(createInsurance), for: .touchUpInside)
        self.confirmButton.isEnabled = false
        self.contentView.addSubview(self.propertiesView)
        NSLayoutConstraint.activate([
            self.propertiesView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.propertiesView.topAnchor.constraint(equalTo: divider4.bottomAnchor),
            self.propertiesView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.propertiesView.bottomAnchor.constraint(equalTo: self.confirmButton.topAnchor, constant: -35.0)
        ])
        self.insurancePresenter?.checkConfirmButton()
    }
    
    func setConfirmButtonEnabled(isEnabled: Bool) {
        self.confirmButton.isEnabled = isEnabled
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PaymentTypeCell.self), for: indexPath) as! PaymentTypeCell
        cell.onClick = {
            self.selected = indexPath.row
            UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }, completion: { _ in
                self.onPaymentTypeSelected(seq: indexPath.row)
            })
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        var data = paymentTypesList[indexPath.row]
        data.selected = indexPath.row == selected
        cell.setData(model: data)
        return cell
    }
    
    func createDivider() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 0.2)
        return view
    }
    
    @objc
    private func backButtonClicked() {
        if let b = backButtonClick { b() }
    }
    
    func onPaymentTypeSelected(seq: Int) {
        self.insurancePresenter?.setPaymentType(paymentType: seq)
    }
    
}
