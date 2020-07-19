//
//  NotificationView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class NotificationView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var onBack: (() -> Void)? = nil
    private var notifications: [NotificationModel] = []
    private var news: [News] = []
    private var expanded: [Bool] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationsHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: NotificationsHeaderView.self))
        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self))
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.onBack?()
    }
    
    func setNotifications(notifications: [NotificationModel]) {
        self.notifications = notifications
        UIView.transition(with: self.tableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
            self.tableView.layoutSubviews()
            self.tableView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setNews(news: [News]) {
        self.news = news
        self.expanded.removeAll()
        (0..<news.count).forEach { _ in self.expanded.append(false) }
        UIView.transition(with: self.tableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
            self.tableView.layoutSubviews()
            self.tableView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCell.self)) as! NewsCell
        cell.setNews(news: self.news[indexPath.row], isExpanded: self.expanded[indexPath.row])
        cell.onMore = {
            self.expanded[indexPath.row] = !self.expanded[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NotificationsHeaderView.self)) as! NotificationsHeaderView
        view.setNotificationList(list: self.notifications)
        view.contentView.backgroundColor = .white
        return view
    }
}

class NewsCell: UITableViewCell {
    
    private lazy var imageIV: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "mobile-chat")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 16.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 16.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("detail".localized(), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Roboto-Medium", size: 14)
        button.setTitleColor(Colors.primaryGreen, for: .normal)
        return button
    }()
    
    var onMore: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(imageIV)
        NSLayoutConstraint.activate([
            self.imageIV.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.imageIV.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            self.imageIV.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.imageIV.heightAnchor.constraint(equalToConstant: 250)
        ])
        imageIV.layer.cornerRadius = 30
        imageIV.layer.masksToBounds = true
        
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.titleLabel.topAnchor.constraint(equalTo: self.imageIV.bottomAnchor, constant: 15),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        self.contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        self.contentView.addSubview(moreButton)
        NSLayoutConstraint.activate([
            self.moreButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.moreButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10),
            self.moreButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
        self.moreButton.addTarget(self, action: #selector(onMoreButton(_:)), for: .touchUpInside)
    }
    
    @objc
    func onMoreButton(_ sender: Any) {
        self.onMore?()
    }
    
    func setNews(news: News, isExpanded: Bool) {
        if let url = URL(string: "\(BASE_URL)\(news.image ?? "")") {
            imageIV.kf.setImage(with: url, placeholder: UIImage(named: "files-dummy")!.imageWithInsets(insetDimen: 30), options: [
                .transition(.fade(1)),
                .cacheOriginalImage]
            )
        }
        
        self.titleLabel.text = news.title
        self.descriptionLabel.text = news.text?.htmlToString
        UIView.animate(withDuration: 0.2) {
            self.descriptionLabel.numberOfLines = isExpanded ? 0 : 5
            self.moreButton.setTitle(isExpanded ? "collapse".localized() : "detail".localized(), for: .normal)
            self.layoutIfNeeded()
        }
        
        
    }
}

class NotificationsHeaderView: UITableViewHeaderFooterView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellHeight: CGFloat = 190
    let cellWidth: CGFloat = 155
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 17)
        label.text = "notification".localized()
        return label
    }()
    
    private lazy var notificationCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 10)
        flowLayout.itemSize = CGSize.init(width: cellWidth, height: cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var notifications: [NotificationModel] = []
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(notificationCV)
        
        notificationCV.register(NotificationCell.self, forCellWithReuseIdentifier: String(describing: NotificationCell.self))
        notificationCV.showsHorizontalScrollIndicator = false
        notificationCV.backgroundColor = .white
        
        notificationCV.delegate = self
        notificationCV.dataSource = self
        
        NSLayoutConstraint.activate([
            self.notificationCV.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.notificationCV.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            self.notificationCV.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.notificationCV.heightAnchor.constraint(equalToConstant: cellHeight),
            self.notificationCV.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
        
        
    }
    
    func setNotificationList(list: Array<NotificationModel>) {
        self.notifications = list
        UIView.transition(with: self.notificationCV, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.notificationCV.reloadData()
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NotificationCell.self), for: indexPath) as! NotificationCell
        cell.setData(notification: notifications[indexPath.row], isFirst: false)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    
    
}



class NotificationCell: UICollectionViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "mobile-chat")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 13.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 12.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 11.0)
        label.lineBreakMode = .byCharWrapping
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            self.iconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.iconImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 25),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])

        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.titleLabel.topAnchor.constraint(equalTo: self.iconImageView.bottomAnchor, constant: 8),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])

        self.contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)


        ])

        self.contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -10).isActive = true
    }
    
    func setData(notification: NotificationModel, isFirst: Bool) {
        titleLabel.text = notification.translates?[translatePosition]?.title
        descriptionLabel.text = notification.translates?[translatePosition]?.description
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        let date = formatter.date(from: notification.createdAt)
        formatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = formatter.string(from: date!)
    }
    
    
    
}
