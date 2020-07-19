
//
//  IncidentDetailListingView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


class FooterView: UITableViewHeaderFooterView {
    
    lazy var footerButton: Button = {
        let button = Button(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("add_plicy".localized(), for: .normal)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(footerButton)
        self.contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            self.footerButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.footerButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.footerButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.footerButton.heightAnchor.constraint(equalToConstant: 45)
        ])        
    }
}

class IncidentDetailListingView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var onAddNewPolis: (() -> Void)? = nil
    var onPolisItemClicked: ((Int, String) -> Void)? = nil
    
    var onAllButton: (() -> Void)? = nil
    var onPinflButton: (() -> Void)? = nil
    
    @IBOutlet weak var incidentsTableView: UITableView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var pinflButton: UIButton!
    @IBOutlet weak var addButton: Button!
    
    
    
    var insurances: [MyInsurance] = [] {
        didSet {
            // .transitionCrossDissolve
            UIView.transition(with: incidentsTableView, duration: 0.2, options: .curveEaseInOut, animations: {
                self.incidentsTableView.reloadData()
            }, completion: nil)
        }
    }
    var loadingView: LoadingView = LoadingView.fromNib()
    var isLoading: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.isLoading {
                    self.loadingView.startAnimating()
                } else {
                    self.loadingView.stopAnimating()
                }
                self.loadingView.layer.opacity = self.isLoading ? 1.0 : 0.0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.allButton.setTitle("all_button".localized(), for: .normal)
        self.pinflButton.setTitle("pinfl_button".localized(), for: .normal)
    }
    
    private func setupUI() {
        self.incidentsTableView.backgroundColor = .clear        
        self.incidentsTableView.register(IncidentDetailListingCell.self, forCellReuseIdentifier: String(describing: IncidentDetailListingCell.self))
//        self.incidentsTableView.register(FooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: FooterView.self))
        self.incidentsTableView.separatorStyle = .none
        self.incidentsTableView.backgroundColor = .clear
        self.incidentsTableView.estimatedRowHeight = 44.0
        self.incidentsTableView.rowHeight = UITableView.automaticDimension
        self.incidentsTableView.sectionFooterHeight = 80.0
        self.incidentsTableView.estimatedSectionFooterHeight = 80.0
        self.incidentsTableView.delegate = self
        self.incidentsTableView.dataSource = self
        self.incidentsTableView.allowsSelection = true
        
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: incidentsTableView.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: incidentsTableView.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: incidentsTableView.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: incidentsTableView.bottomAnchor)
        ])
        self.loadingView.layer.opacity = 0.0
        self.allButtonActivate()
        self.addButton.setTitle("add_plicy".localized(), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.insurances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IncidentDetailListingCell = tableView.dequeueReusableCell(withIdentifier: String(describing: IncidentDetailListingCell.self)) as! IncidentDetailListingCell
        cell.setData(insurance: insurances[indexPath.row], isLast: indexPath.row == insurances.count - 1)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onPolisItemClicked?(insurances[indexPath.row].id, insurances[indexPath.row].product?.name ?? "osago")
    }
    
    @objc
    private func onAddButtonClicked() {
        
    }
    
    @IBAction func addButtonActtion(_ sender: Any) {
        self.onAddNewPolis?()
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: FooterView.self)) as! FooterView
//        footer.footerButton.addTarget(self, action: #selector(onAddButtonClicked), for: .touchUpInside)
//        return footer
//    }
    
    private func allButtonActivate() {
        
        UIView.animate(withDuration: 0.2) {
            self.allButton.layer.borderWidth = 1.0
            self.allButton.layer.borderColor = Colors.primaryGreen.cgColor
            self.allButton.layer.cornerRadius = self.allButton.bounds.height/2.0
            self.allButton.layer.masksToBounds = true
            self.allButton.setTitleColor(Colors.primaryGreen, for: .normal)
            
            self.pinflButton.layer.borderWidth = 1.0
            self.pinflButton.layer.borderColor = Colors.pageIndicatorGray.cgColor
            self.pinflButton.layer.cornerRadius = self.pinflButton.bounds.height/2.0
            self.pinflButton.layer.masksToBounds = true
            self.pinflButton.setTitleColor(Colors.pageIndicatorGray, for: .normal)      
        }
    }
    
    private func pinflButtonActivate() {
        UIView.animate(withDuration: 0.2) {
            self.pinflButton.layer.borderWidth = 1.0
            self.pinflButton.layer.borderColor = Colors.primaryGreen.cgColor
            self.pinflButton.layer.cornerRadius = self.pinflButton.bounds.height/2.0
            self.pinflButton.layer.masksToBounds = true
            self.pinflButton.setTitleColor(Colors.primaryGreen, for: .normal)
                
            self.allButton.layer.borderWidth = 1.0
            self.allButton.layer.borderColor = Colors.pageIndicatorGray.cgColor
            self.allButton.layer.cornerRadius = self.allButton.bounds.height/2.0
            self.allButton.layer.masksToBounds = true
            self.allButton.setTitleColor(Colors.pageIndicatorGray, for: .normal)
        }
    }
    
    @IBAction func allButtonAction(_ sender: Any) {
        if !isLoading {
            allButtonActivate()
            onAllButton?()
        }
    }
    
    @IBAction func pinflButtonAction(_ sender: Any) {
        if !isLoading {
            pinflButtonActivate()
            onPinflButton?()
        }
    }
    
    
}
