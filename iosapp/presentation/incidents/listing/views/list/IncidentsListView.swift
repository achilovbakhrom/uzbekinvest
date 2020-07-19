//
//  IncidentsListView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/30/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class IncidentsListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var incidentsTableView: UITableView!
    
    var incidents: [Incident] = [] {
        didSet {
            UIView.transition(with: self.incidentsTableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.incidentsTableView.reloadData()
                self.incidentsTableView.layoutSubviews()
            }, completion: nil)
        }
    }
    var onAddIncident: (() -> Void)? = nil
    var onIncidentSelect: ((Incident) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        incidentsTableView.delegate = self
        incidentsTableView.dataSource = self
        
        incidentsTableView.sectionHeaderHeight = UITableView.automaticDimension
        incidentsTableView.estimatedSectionHeaderHeight = 90.0
        
        incidentsTableView.rowHeight = UITableView.automaticDimension
        incidentsTableView.estimatedRowHeight = 90.0
        incidentsTableView.register(IncidentsListHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: IncidentsListHeaderView.self))
        incidentsTableView.register(IncidentsListCell.self, forCellReuseIdentifier: String(describing: IncidentsListCell.self))
    }
    
    
    @IBAction func onIncidentsAction(_ sender: Any) {
        self.onAddIncident?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidents.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: IncidentsListHeaderView.self))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IncidentsListCell.self)) as! IncidentsListCell
        cell.setData(incident: incidents[indexPath.row], isLast: incidents.count - 1 == indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onIncidentSelect?(incidents[indexPath.row])
    }
    
}

class IncidentsListHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func setupUI() {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = "my_orders".localized()
        titleLabel.font = UIFont.init(name: "Roboto-Medium", size: 20)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        let subTitle = UILabel(frame: .zero)
        subTitle.text = "my_incidents_sub_desc".localized()
        subTitle.font = UIFont.init(name: "Roboto-Regular", size: 12)
        subTitle.textColor = UIColor.black.withAlphaComponent(0.3)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            subTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
        self.contentView.backgroundColor = .white
    }
    
}

class IncidentsListCell: UITableViewCell {
    
    private lazy var orderNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 12)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    var bottomConstraint: NSLayoutConstraint!
    
    private func setupUI() {
        let statusContainer = UIView(frame: .zero)
        statusContainer.translatesAutoresizingMaskIntoConstraints = false
        statusContainer.backgroundColor = UIColor.init(red: 120.0/255.0, green: 203.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        self.contentView.addSubview(statusContainer)
        NSLayoutConstraint.activate([
            statusContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            statusContainer.heightAnchor.constraint(equalToConstant: 28),
            statusContainer.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.centerXAnchor, constant: 10),
            
        ])
        statusContainer.layer.cornerRadius = 14.0
        statusContainer.layer.masksToBounds = true
        
        statusContainer.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.trailingAnchor.constraint(equalTo: statusContainer.trailingAnchor, constant: -12),
            statusLabel.centerYAnchor.constraint(equalTo: statusContainer.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: statusContainer.leadingAnchor, constant: 12)
        ])
        
        
        self.contentView.addSubview(orderNameLabel)
        NSLayoutConstraint.activate([
            orderNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            orderNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            orderNameLabel.centerYAnchor.constraint(equalTo: statusContainer.centerYAnchor),
            orderNameLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -10),
            
        ])
        
        self.contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            dateLabel.topAnchor.constraint(equalTo: self.orderNameLabel.bottomAnchor, constant: 15)
        ])
        
        let div = UIView(frame: .zero)
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        self.contentView.addSubview(div)
        bottomConstraint = div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            div.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 12),
            div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            div.heightAnchor.constraint(equalToConstant: 1.0),
            bottomConstraint
        ])
    }
    
    func setData(incident: Incident, isLast: Bool) {
        self.orderNameLabel.text = (incident.order?.product?.translates?.isEmpty ?? false) ? "" :  incident.order?.product?.translates?[translatePosition]?.name
        switch incident.status ?? "" {
        case "new":
            self.statusLabel.text = "incident_new".localized()
            break
        case "canceled":
            self.statusLabel.text = "incident_cancelled".localized()
            break
        case "confirmed":
            self.statusLabel.text = "incident_confirmed".localized()
            break
        case "paid":
            self.statusLabel.text = "incident_paid".localized()
            break
        case "denied":
            self.statusLabel.text = "incident_completed".localized()
            break
        default:
            break
        }        
        self.dateLabel.text = "\(incident.order?.startDate ?? "") - \(incident.order?.endDate ?? "")"
        bottomConstraint.constant = isLast ? -75.0 : 0.0
    }
}
