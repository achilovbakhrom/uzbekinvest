//
//  MenuCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: UICollectionViewCell {
    
    private lazy var cView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.init(name: "Roboto-Medium", size: 15)
        label.textColor = UIColor.init(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
        return label
    }()
    
    private lazy var saleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 13)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red: 238.0 / 255.0, green: 76.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var modelDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.init(name: "Roboto-Regular", size: 13)
        label.textColor = UIColor.init(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 0.6)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var moreButtonTopConstraint: NSLayoutConstraint! = nil
    private var product: Product? = nil
    private var more: UILabel!
    var cellClicked: ((Product?) -> Void)? = nil
    
    var iconLeading: NSLayoutConstraint!
    var titleLeading: NSLayoutConstraint!
    var divLeading: NSLayoutConstraint!
    var descLeading: NSLayoutConstraint!
    var salesLeading: NSLayoutConstraint!
    var moreLeading: NSLayoutConstraint!
    
    
    var titleTrailing: NSLayoutConstraint!
    var descTrailing: NSLayoutConstraint!
    var salesTop: NSLayoutConstraint!
    var cellHeightAnchor: NSLayoutConstraint!
    
    
    
    private func setupView() {
        let width = UIScreen.main.bounds.width * 0.96
        self.contentView.addSubview(self.cView)
        NSLayoutConstraint.activate([
            self.cView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.cView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.cView.widthAnchor.constraint(equalToConstant: width/2),
            self.cView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        self.cView.addSubview(icon)
        self.topConstraint = self.icon.topAnchor.constraint(equalTo: self.cView.topAnchor, constant: 15)
        self.iconLeading = self.icon.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28)
        NSLayoutConstraint.activate([
            iconLeading,
            self.topConstraint,
            self.icon.widthAnchor.constraint(equalTo: self.cView.widthAnchor, multiplier: 0.39),
            self.icon.heightAnchor.constraint(equalTo: self.icon.widthAnchor)
        ])
        
        self.cView.addSubview(title)
        titleLeading = self.title.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28)
        titleTrailing = self.title.trailingAnchor.constraint(equalTo: self.cView.trailingAnchor, constant: -28)
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 18),
            titleLeading,
            titleTrailing
        ])
        
        let div = createDiv()
        self.cView.addSubview(div)
        divLeading = div.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28)
        NSLayoutConstraint.activate([
            divLeading,
            div.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 17),
            div.widthAnchor.constraint(equalToConstant: 35),
            div.heightAnchor.constraint(equalToConstant: 2)
        ])

        self.cView.addSubview(self.modelDescription)
        descLeading = self.modelDescription.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28)
        descTrailing = self.modelDescription.trailingAnchor.constraint(equalTo: self.cView.trailingAnchor, constant: -28)
        NSLayoutConstraint.activate([
            descLeading,
            self.modelDescription.topAnchor.constraint(equalTo: div.bottomAnchor, constant: 18),
            descTrailing
        ])
        
        self.cView.addSubview(self.saleLabel)
        salesLeading = self.saleLabel.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28)
        salesTop = self.saleLabel.topAnchor.constraint(equalTo: self.modelDescription.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([
            salesLeading,
            self.saleLabel.topAnchor.constraint(equalTo: self.modelDescription.bottomAnchor, constant: 10),
            self.saleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.modelDescription.trailingAnchor, constant: -6),
            self.saleLabel.heightAnchor.constraint(equalToConstant: 24.0)
        ])
        
        more = UILabel(frame: .zero)
        more.font = UIFont.init(name: "Roboto-Medium", size: 15)
        more.translatesAutoresizingMaskIntoConstraints = false
        more.text = "detail".localized()
        more.textColor = Colors.primaryGreen
        self.cView.addSubview(more)
        moreLeading = more.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28)
        moreButtonTopConstraint = more.topAnchor.constraint(equalTo: self.saleLabel.bottomAnchor, constant: 18)
        NSLayoutConstraint.activate([
            moreLeading,
            moreButtonTopConstraint
        ])
        self.bottomConstraint = more.bottomAnchor.constraint(equalTo: self.cView.bottomAnchor, constant: -20)
        self.bottomConstraint.isActive = true
        
        var height = UIScreen.main.bounds.height

        if isIPhone4OrNewer() {
            height = height/2
        } else if isIPhoneSE() {
            height = height/2
        } else if isIPhonePlus() {
            height = height/2.4
        } else if isIPhoneX() {
            height = height/2.6
        } else {
            height = height/3
        }

        self.cellHeightAnchor = self.contentView.heightAnchor.constraint(equalToConstant: height)
        self.cellHeightAnchor.isActive = true

        self.cView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor).isActive = true
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
    
    @objc
    private func cellTapped() {
        cellClicked?(self.product)
    }
    
    private func createDiv() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.primaryGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }
    
    public func setData(model: Product, index: Int, isLast: Bool, isFromDashboard: Bool = true) {
        self.product = model
        
        
        switch product?.name {
        case "osago":
            self.icon.image = UIImage(named: "car")
            break
        case "kasko":
            self.icon.image = UIImage(named: "kasko")
            break
        case "my-life":
            self.icon.image = UIImage(named: "kasko")
            break;
        case "pledged-transport":
            self.icon.image = UIImage(named: "mandatory-logo")
            break
        case "my-family":
            self.icon.image = UIImage(named: "home")
            break
        case "pledged-property":
            self.icon.image = UIImage(named: "ipoteka")
            break
        case "health-insurance":
            self.icon.image = UIImage(named: "health")
            break
        case "my-health":
            self.icon.image = UIImage(named: "accident")
            break
        case "travel":
            self.icon.image = UIImage(named: "travel")
            break
        case "sport-accident":
            self.icon.image = UIImage(named: "sport")
            break
        case "technical-help":
            self.icon.image = UIImage(named: "tow")
            break
        case "gas-home":
            self.icon.image = UIImage(named: "gas")
            break
        case "gas-auto":
            self.icon.image = UIImage(named: "gas-equipment")
            break
        case "infectious-disease":
            self.icon.image = UIImage(named: "infection")
            break
        case "mobile-phone":
            self.icon.image = UIImage(named: "mobilePhone")
            break
        case "luggage-out":
            self.icon.image = UIImage(named: "luggage")
            break
        default:
            self.icon.image = UIImage(named: "unknown_insurance")
            break
        }
        
        model.translates?.forEach({ t in
            if t?.lang == translateCode {
                self.title.text = t?.name
                self.modelDescription.text = t?.description
            }
        })
        
        var height = UIScreen.main.bounds.height

        if isIPhone4OrNewer() {
            height = height/2
        } else if isIPhoneSE() {
            height = height/2
        } else if isIPhonePlus() {
            height = height/2.4
        } else if isIPhoneX() {
            height = height/2.6
        } else {
            height = height/3
        }
        
        
        
        if (index == 0 || index == 1) && isFromDashboard {
            if isIPhone4OrNewer() {
                self.topConstraint.constant = 35
                height = height + 35
            } else if isIPhoneSE() {
                self.topConstraint.constant = 45
                height = height + 45
            } else if isIPhonePlus() {
                self.topConstraint.constant = 55
                height = height + 75
            } else if isIPhoneX() {
                self.topConstraint.constant = 75
                height = height + 75
            } else {
                height = height + 75
                self.topConstraint.constant = 75
            }
        } else {
            height = height + 15
            self.topConstraint.constant = 15
        }
        
        
        
        if isIPhone4OrNewer() {
            self.bottomConstraint.constant = isLast ? -110 : -15
            self.cellHeightAnchor.constant = isLast ? 110 + height : height
        } else if isIPhoneSE() {
            self.bottomConstraint.constant = isLast ? -125 : -15
            self.cellHeightAnchor.constant = isLast ? 125 + height : height
        } else if isIPhonePlus() {
            self.bottomConstraint.constant = isLast ? -135 : -15
            self.cellHeightAnchor.constant = isLast ? 135 + height : height
        } else if isIPhoneX() {
            self.bottomConstraint.constant = isLast ? -135 : -15
            self.cellHeightAnchor.constant = isLast ? 135 + height : height
        } else if isIPhoneXOrHigher() {
            self.cellHeightAnchor.constant = isLast ? 205 + height : height
            self.bottomConstraint.constant = isLast ? -205 : -15
        }

        if let discount = product?.discount, discount > 0 {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            
            self.saleLabel.layer.opacity = 1.0
            self.saleLabel.text = "  \("sale".localized()) - \(formatter.string(from: NSNumber(value: discount)) ?? "0")%  "
            self.moreButtonTopConstraint.constant = 10
        } else {
            self.saleLabel.layer.opacity = 0.0
            self.moreButtonTopConstraint.constant = -15
        }
        
    }
    
    
}
