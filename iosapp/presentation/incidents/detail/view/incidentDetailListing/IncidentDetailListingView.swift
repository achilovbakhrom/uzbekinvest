
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
    var onPolisItemClicked: ((Int) -> Void)? = nil
    
    @IBOutlet weak var incidentsTableView: UITableView!
    
    var insurances: [MyInsurance] = [] {
        didSet {
            // .transitionCrossDissolve
            UIView.transition(with: incidentsTableView, duration: 0.2, options: .curveEaseInOut, animations: {
                self.incidentsTableView.reloadData()
            }, completion: nil)
        }
    }
    
    var isLoading: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        self.incidentsTableView.backgroundColor = .clear        
        self.incidentsTableView.register(IncidentDetailListingCell.self, forCellReuseIdentifier: String(describing: IncidentDetailListingCell.self))
        self.incidentsTableView.register(FooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: FooterView.self))
        self.incidentsTableView.separatorStyle = .none
        self.incidentsTableView.backgroundColor = .clear
        self.incidentsTableView.estimatedRowHeight = 44.0
        self.incidentsTableView.rowHeight = UITableView.automaticDimension
        self.incidentsTableView.sectionFooterHeight = 80.0
        self.incidentsTableView.estimatedSectionFooterHeight = 80.0
        self.incidentsTableView.delegate = self
        self.incidentsTableView.dataSource = self
        self.incidentsTableView.allowsSelection = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.insurances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IncidentDetailListingCell = tableView.dequeueReusableCell(withIdentifier: String(describing: IncidentDetailListingCell.self)) as! IncidentDetailListingCell
        cell.setData(insurance: insurances[indexPath.row])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onPolisItemClicked?(insurances[indexPath.row].id)
    }
    
    @objc
    private func onAddButtonClicked() {
        self.onAddNewPolis?()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: FooterView.self)) as! FooterView
        footer.footerButton.addTarget(self, action: #selector(onAddButtonClicked), for: .touchUpInside)
        return footer
    }
    
    
}
