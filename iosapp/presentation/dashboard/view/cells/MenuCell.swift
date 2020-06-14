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
        label.backgroundColor = UIColor(red: 253.0 / 255.0, green: 121.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
//        label.textAlignment = .center
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
    
    private func setupView() {
        let width = UIScreen.main.bounds.width*0.95
        
        self.contentView.addSubview(self.cView)
        NSLayoutConstraint.activate([
            self.cView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.cView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.cView.widthAnchor.constraint(equalToConstant: width/2),
            self.cView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        self.cView.addSubview(icon)
        self.topConstraint = self.icon.topAnchor.constraint(equalTo: self.cView.topAnchor, constant: 28)
        NSLayoutConstraint.activate([
            self.icon.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28),
            self.topConstraint,
            self.icon.widthAnchor.constraint(equalTo: self.cView.widthAnchor, multiplier: 0.39),
            self.icon.heightAnchor.constraint(equalTo: self.icon.widthAnchor)

        ])
        
        self.cView.addSubview(title)
        NSLayoutConstraint.activate([
            self.title.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28),
            self.title.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 18),
            self.title.trailingAnchor.constraint(equalTo: self.cView.trailingAnchor, constant: -28)
        ])
        
        let div = createDiv()
        self.cView.addSubview(div)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28),
            div.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 17),
            div.widthAnchor.constraint(equalToConstant: 35),
            div.heightAnchor.constraint(equalToConstant: 2)
        ])

        self.cView.addSubview(self.modelDescription)
        NSLayoutConstraint.activate([
            self.modelDescription.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28),
            self.modelDescription.topAnchor.constraint(equalTo: div.bottomAnchor, constant: 18),
            self.modelDescription.trailingAnchor.constraint(equalTo: self.cView.trailingAnchor, constant: -28)
        ])

        self.cView.addSubview(self.saleLabel)
        NSLayoutConstraint.activate([
            self.saleLabel.leadingAnchor.constraint(equalTo: self.modelDescription.leadingAnchor),
            self.saleLabel.topAnchor.constraint(equalTo: self.modelDescription.bottomAnchor, constant: 10),
            self.saleLabel.trailingAnchor.constraint(equalTo: self.modelDescription.trailingAnchor),
            self.saleLabel.heightAnchor.constraint(equalToConstant: 24.0)
            
        ])
        
        more = UILabel(frame: .zero)
        more.font = UIFont.init(name: "Roboto-Medium", size: 15)
        more.translatesAutoresizingMaskIntoConstraints = false
        more.text = "detail".localized()
        more.textColor = Colors.primaryGreen
        self.cView.addSubview(more)
        
        moreButtonTopConstraint = more.topAnchor.constraint(equalTo: self.saleLabel.bottomAnchor, constant: 18)
        
        NSLayoutConstraint.activate([
            more.leadingAnchor.constraint(equalTo: self.cView.leadingAnchor, constant: 28),
            moreButtonTopConstraint,
            more.bottomAnchor.constraint(equalTo: self.cView.bottomAnchor, constant: 10)
        ])
        self.bottomConstraint = more.bottomAnchor.constraint(equalTo: self.cView.bottomAnchor, constant: -20)
        self.bottomConstraint.isActive = true
        
        self.cView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
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
        if (index == 0 || index == 1) && isFromDashboard {
            if isIPhone4OrNewer() {
                self.topConstraint.constant = 35
            } else if isIPhoneSE() {
                self.topConstraint.constant = 45
            } else if isIPhonePlus() {
                self.topConstraint.constant = 75
            } else {
                self.topConstraint.constant = 75
            }
        }
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
            break
        }
        self.title.text = model.translates?[translatePosition]?.name
        self.modelDescription.text = model.translates?[translatePosition]?.description
        if isIPhone4OrNewer() {
            self.bottomConstraint.constant = isLast ? -110 : -15
        } else if isIPhoneSE() {
            self.bottomConstraint.constant = isLast ? -135 : -15
        } else if isIPhoneXOrHigher() {
            self.bottomConstraint.constant = isLast ? -205 : -15
        }
        
        if let discount = product?.discount, discount > 0 {
            self.saleLabel.isHidden = false
            self.saleLabel.text = "  \("sale".localized()) - \(discount)%"
        } else {
//            self.cView.removeConstraint(moreButtonTopConstraint)
            self.saleLabel.isHidden = true
//            self.moreButtonTopConstraint = self.more.topAnchor.constraint(equalTo: self.modelDescription.bottomAnchor, constant: 10)
        }
    }
    
    
}
