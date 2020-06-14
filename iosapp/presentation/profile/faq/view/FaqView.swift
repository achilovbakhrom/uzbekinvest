//
//  FaqView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/12/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class FaqView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    var onBack: (() -> Void)? = nil
    @IBOutlet weak var faqTableView: UITableView!
    
    private var faqList: [FaqCollapsible] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        faqTableView.delegate = self
        faqTableView.dataSource = self
        faqTableView.showsVerticalScrollIndicator = false
        faqTableView.separatorStyle = .none
        faqTableView.rowHeight = UITableView.automaticDimension
        faqTableView.estimatedRowHeight = 44.0
        faqTableView.register(FaqListCell.self, forCellReuseIdentifier: String(describing: FaqListCell.self))
    }
    
    func setFaqList(faqList: [Question]) {
        self.faqList = faqList.map { FaqCollapsible.init(faq: $0, collapsed: true) }
        UIView.transition(with: faqTableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.faqTableView.reloadData()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FaqListCell.self)) as! FaqListCell
        cell.onClick = {
            self.faqList[indexPath.row].collapsed = !self.faqList[indexPath.row].collapsed
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        cell.setData(question: faqList[indexPath.row].faq, collapsed: faqList[indexPath.row].collapsed)
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.onBack?()
    }
    
}

class FaqListCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 17.0)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.isUserInteractionEnabled = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: PaddingLabel = {
        let label = PaddingLabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 15.0)
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        label.backgroundColor = Colors.primaryGreen.withAlphaComponent(0.3)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var onClick: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        self.titleLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onClickAction(_:))))
        
        self.contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        let div = UIView.init(frame: .zero)
        div.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        div.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(div)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            div.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10),
            div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            div.heightAnchor.constraint(equalToConstant: 1.0),
            div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setData(question: Question, collapsed: Bool) {
        self.titleLabel.text = question.question
        
        UIView.animate(withDuration: 0.3) {
            if collapsed {
                self.descriptionLabel.layer.opacity = 0.0
                self.descriptionLabel.text = ""
            } else {
                self.descriptionLabel.layer.opacity = 1.0
                self.descriptionLabel.text = question.answer
            }
        }
        
    }
    
    @objc
    private func onClickAction(_ gesture: UITapGestureRecognizer) {
        self.onClick?()
    }
    
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

struct FaqCollapsible {
    var faq: Question
    var collapsed: Bool
}
