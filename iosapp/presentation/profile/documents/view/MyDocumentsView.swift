//
//  MyDocumentsView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyDocumentsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    private lazy var myDocsViewPager = MyDocumentsViewPager(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var onRemove: ((Int) -> Void)? = nil
    
    var onUpload: ((Int) -> Void)? = nil
    
    var documents: [Document] = [] {
        didSet {
            UIView.transition(with: categoriesCollectionView, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.categoriesCollectionView.reloadData()
            }, completion: nil)
            self.myDocsViewPager.setDocuments(documents: documents)
        }
    }
    
    var userFiles: [UserFile] = [] {
        didSet { self.myDocsViewPager.setUserFiles(userFiles: userFiles) }
    }
    
    var onBack: (() -> Void)? = nil
    var onDocumentChanged: ((Document, Int) -> Void)? = nil
    var selected: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesCollectionView.register(MyDocumentsCell.self, forCellWithReuseIdentifier: String(describing: MyDocumentsCell.self))
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        let flowLayout = (categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)
        flowLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout?.scrollDirection = .horizontal
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        self.findViewController()?.addChild(myDocsViewPager)
        self.contentView.addSubview(myDocsViewPager.view)
        self.myDocsViewPager.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.myDocsViewPager.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.myDocsViewPager.view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.myDocsViewPager.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.myDocsViewPager.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.myDocsViewPager.onPageChanged = { page in
            self.selected = page
            self.categoriesCollectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
            self.categoriesCollectionView.reloadData()
        }
        
        self.myDocsViewPager.onRemove = {
            self.onRemove?($0)
        }
        self.myDocsViewPager.onUpload = {
            self.onUpload?($0)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.onBack?()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyDocumentsCell.self), for: indexPath) as! MyDocumentsCell
        cell.setData(document: documents[indexPath.row], isFirst: indexPath.row == 0, isSelected: selected == indexPath.row, isLast: indexPath.row == documents.count - 1)
        cell.onDocClick = {
            self.onDocumentChanged?($0, indexPath.row)
            self.selected = indexPath.row
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.categoriesCollectionView.reloadData()
            let vc = self.myDocsViewPager.vcs[indexPath.row]
            self.myDocsViewPager.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
        return cell
    }
}

class MyDocumentsCell: UICollectionViewCell {
    
    private lazy var borderView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 12.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    var leadingConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    var myDocument: Document!
    var onDocClick: ((Document) -> Void)? = nil
    func setupUI() {
        self.contentView.addSubview(borderView)
        self.leadingConstraint = self.borderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5)
        NSLayoutConstraint.activate([
            leadingConstraint,
            borderView.heightAnchor.constraint(equalToConstant: 30),
            borderView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        borderView.layer.borderWidth = 1.0
        borderView.layer.cornerRadius = 15.0
        borderView.layer.borderColor = Colors.primaryGreen.cgColor
        borderView.layer.masksToBounds = true
        
        self.borderView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.borderView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.borderView.trailingAnchor, constant: -15),
            titleLabel.centerYAnchor.constraint(equalTo: self.borderView.centerYAnchor),
        ])
        bottomConstraint = borderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        bottomConstraint.isActive = true
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onItemClick(gestureRecognizer:))))
    }
    
    @objc
    private func onItemClick(gestureRecognizer: UITapGestureRecognizer) {
        onDocClick?(myDocument)
    }
    
    func setData(document: Document, isFirst: Bool, isSelected: Bool, isLast: Bool) {
        self.leadingConstraint.constant = isFirst ? 31 : 5
        
        document.translates?.forEach({ t in
            if t?.lang == translateCode {
                titleLabel.text = t?.name
            }
        })
        self.myDocument = document
        let color: UIColor = isSelected ? Colors.primaryGreen : Colors.pageIndicatorGray
        titleLabel.textColor = color
        self.borderView.layer.borderColor = color.cgColor
        self.bottomConstraint.constant = isLast ? -31 : 0
    }
    
}
