//
//  PropertyRowView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

enum PropertyRowType {
    case info
    case doc
    case upload
}

class PropertyRowView: UIView {
    
    var mode: PropertyRowType = .info {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    var isStatusChecked = false {
        didSet {
            if isStatusChecked {
                self.statusImageView.image = UIImage(named: "check-mark")
            } else {
                self.statusImageView.image = UIImage(named: "warning-icon")
            }
        }
    }
    
    var onChnageButtonClicked: (() -> Void)?
    var onUploadButtonClicked: (() -> Void)?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var docImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "doc-file")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        label.font = UIFont.init(name: "Roboto-Regular", size: 12.0)
        return label
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.primaryGreen, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 14)
        button.setTitle("change".localized(), for: .normal)
        return button
    }()
    
    lazy var uploadButton: UploadButton = {
        let button = UploadButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Загрузить  ", for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initUI()
    }
    
    var titleLabelLeadingConstraint: NSLayoutConstraint!
    var titleLabelTopConstraint: NSLayoutConstraint!
    
    var contentLabelTopConstraint: NSLayoutConstraint!
    var contentLabelLeadingConstraint: NSLayoutConstraint!
    var contentLabelTrailingConstraint: NSLayoutConstraint!
    
    var docTopIVConstraint: NSLayoutConstraint!
    var docLeadingIVConstraint: NSLayoutConstraint!
    var docHeightIVConstraint: NSLayoutConstraint!
    var docWidthIVConstraint: NSLayoutConstraint!
    
    var statusIVCenterYConstraint: NSLayoutConstraint!
    var statusIVTrailingConstraint: NSLayoutConstraint!
    var statusIVWidthConstraint: NSLayoutConstraint!
    var statusIVHeightConstraint: NSLayoutConstraint!
    
    var descriptionLabelTopConstraint: NSLayoutConstraint!
    var descriptionLabelLeadingConstraint: NSLayoutConstraint!
    var descriptionLabelTrailingConstraint: NSLayoutConstraint!
    
    var changeButtonLeadingConstraint: NSLayoutConstraint!
    var changeButtonTopConstraint: NSLayoutConstraint!
    
    var uploadButtonLeadingConstraint: NSLayoutConstraint!
    var uploadButtonTopConstraint: NSLayoutConstraint!
    
    private func initUI() {
        self.addSubview(titleLabel)
        self.titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 31.0)
        self.titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 23.0)
        
        
        self.addSubview(contentLabel)
        self.contentLabelTopConstraint = self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10.0)
        self.contentLabelLeadingConstraint = self.contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 31.0)
        self.addSubview(docImageView)
        
        self.docTopIVConstraint = docImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 21.0)
        self.docLeadingIVConstraint = docImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 31)
        self.docHeightIVConstraint = docImageView.heightAnchor.constraint(equalToConstant: 42.0)
        self.docWidthIVConstraint = docImageView.widthAnchor.constraint(equalToConstant: 34.0)
        
        self.addSubview(statusImageView)
        self.statusIVCenterYConstraint = statusImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.statusIVTrailingConstraint = self.statusImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -31)
        self.statusIVWidthConstraint = self.statusImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.08)
        self.statusIVHeightConstraint = self.statusImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.08)
        
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.changeButton)
        self.addSubview(self.uploadButton)
        self.changeButton.isUserInteractionEnabled = true
        self.changeButton.addTarget(self, action: #selector(changeClicked(_:)), for: .touchUpInside)
        self.uploadButton.addTarget(self, action: #selector(uploadButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc
    private func uploadButtonClicked(_ sender: Any) {
        self.onUploadButtonClicked?()
    }
    
    @objc
    private func changeClicked(_ sender: Any) {
        self.onChnageButtonClicked?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch self.mode {
        case .info:
            uploadButton.isHidden = true
            docImageView.isHidden = true
            descriptionLabel.isHidden = true
            changeButton.isHidden = false
            
            self.contentLabel.font = UIFont.init(name: "Roboto-Regular", size: 16.0)
            self.contentLabelLeadingConstraint = self.contentLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
            self.contentLabelTopConstraint = self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 14.0)
            self.contentLabelTrailingConstraint = self.contentLabel.trailingAnchor.constraint(equalTo: self.statusImageView.leadingAnchor, constant: -10)
            
            
            self.changeButtonTopConstraint = self.changeButton.topAnchor.constraint(equalTo: self.contentLabel.bottomAnchor, constant: 14)
            self.changeButtonLeadingConstraint = self.changeButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
            
            NSLayoutConstraint.activate([
                self.titleLabelTopConstraint,
                self.titleLabelLeadingConstraint,
                self.statusIVCenterYConstraint,
                self.statusIVTrailingConstraint,
                self.statusIVWidthConstraint,
                self.statusIVHeightConstraint,
                self.contentLabelTopConstraint,
                self.contentLabelTrailingConstraint,
                self.contentLabelLeadingConstraint
            ])
            
            NSLayoutConstraint.activate([
                self.changeButtonTopConstraint,
                self.changeButtonLeadingConstraint,
                self.changeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21)
            ])
            break
        case .doc:
            uploadButton.isHidden = true
            docImageView.isHidden = false
            descriptionLabel.isHidden = false
            changeButton.isHidden = false
            
            self.contentLabel.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
            self.contentLabelLeadingConstraint = self.contentLabel.leadingAnchor.constraint(equalTo: self.docImageView.trailingAnchor, constant: 27)
            self.contentLabelTopConstraint = self.contentLabel.topAnchor.constraint(equalTo: self.docImageView.topAnchor)
            self.contentLabelTrailingConstraint = self.contentLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.statusImageView.leadingAnchor, constant: -10)
            
            self.descriptionLabelTopConstraint = self.descriptionLabel.topAnchor.constraint(equalTo: self.contentLabel.bottomAnchor, constant: 6)
            self.descriptionLabelLeadingConstraint = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentLabel.leadingAnchor)
            self.descriptionLabelTrailingConstraint = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.statusImageView.leadingAnchor, constant: 15)
            
            self.changeButtonTopConstraint = self.changeButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 22)
            self.changeButtonLeadingConstraint = self.changeButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
            
            NSLayoutConstraint.activate([
                self.titleLabelTopConstraint,
                self.titleLabelLeadingConstraint,
                self.contentLabelTopConstraint,
                self.contentLabelTrailingConstraint,
                self.contentLabelLeadingConstraint,
                self.statusIVCenterYConstraint,
                self.statusIVTrailingConstraint,
                self.docTopIVConstraint,
                self.docLeadingIVConstraint,
                self.docWidthIVConstraint,
                self.docHeightIVConstraint,
                self.descriptionLabelTopConstraint,
                self.descriptionLabelLeadingConstraint,
                self.descriptionLabelTrailingConstraint
            ])
            
            NSLayoutConstraint.activate([
                self.changeButtonTopConstraint,
                self.changeButtonLeadingConstraint,
                self.changeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21)
            ])
            
            break
        
        case .upload:
            uploadButton.isHidden = false
            docImageView.isHidden = true
            descriptionLabel.isHidden = true
            changeButton.isHidden = true
            
            self.uploadButtonLeadingConstraint = self.uploadButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 31)
            self.uploadButtonTopConstraint = self.uploadButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 14)
            
            
            NSLayoutConstraint.activate([
                self.titleLabelTopConstraint,
                self.titleLabelLeadingConstraint,
                self.statusIVCenterYConstraint,
                self.statusIVTrailingConstraint,
                self.statusIVWidthConstraint,
                self.statusIVHeightConstraint,
                self.uploadButtonLeadingConstraint,
                self.uploadButtonTopConstraint,
                self.uploadButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
            ])
            
            break
        }
    }
}
