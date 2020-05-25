//
//  OfficesListVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


class OfficesListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var officesList: Array<Office> = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.tableView.register(OfficeListCell.self, forCellReuseIdentifier: String(describing: OfficeListCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setOfficesList(officesList: Array<Office>) {
        self.officesList = officesList
        UIView.transition(with: self.tableView, duration: 0.3, options: .curveEaseInOut, animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.officesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OfficeListCell.self), for: indexPath) as! OfficeListCell
        cell.setData(office: officesList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let dialogView: MapListDialogView = MapListDialogView.fromNib()
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(dialogView)
        NSLayoutConstraint.activate([
            dialogView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor),
            dialogView.topAnchor.constraint(equalTo: alert.view.topAnchor),
            dialogView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor),
            dialogView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
            dialogView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.8)
        ])
        dialogView.layer.cornerRadius = 12
        dialogView.layer.masksToBounds = true
        let office = officesList[indexPath.row]
        dialogView.branchName.text = office.translates?[0]?.address
        dialogView.branchAddress.text = office.translates?[0]?.address
        dialogView.workTime.text = office.translates?[0]?.workTime
        dialogView.onRouteBuild = {
            self.dismiss(animated: true) {
                let directionsVC = DirectionsVC()
                self.present(directionsVC, animated: true, completion: nil)
            }
        }
        self.present(alert, animated: true, completion: {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped(gesture:))))
        })
    }
    
    
    @objc
    private func alertControllerBackgroundTapped(gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

class OfficeListCell: UITableViewCell {
    
    private lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var address: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.primaryGreen, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 14)
        button.setTitle("detail".localized(), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(name)
        NSLayoutConstraint.activate([
            self.name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.name.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        self.contentView.addSubview(address)
        NSLayoutConstraint.activate([
            self.address.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.address.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10),
            self.address.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
        ])
        
        self.contentView.addSubview(moreButton)
        NSLayoutConstraint.activate([
            self.moreButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.moreButton.topAnchor.constraint(equalTo: self.address.bottomAnchor, constant: 8)
        ])
        
        let divider = UIView(frame: .zero)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.contentView.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: self.moreButton.bottomAnchor, constant: 15.0),
            divider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            divider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            divider.heightAnchor.constraint(equalToConstant: 1.0),
            divider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.contentView.isUserInteractionEnabled = true
    }
    
    
    func setData(office: Office) {
        self.name.text = office.region?.translates?.count ?? 0 > 0 ? office.region?.translates?[0]?.name : ""
        self.address.text = office.translates?[0]?.address
    }
}
