//
//  InsuranceListView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class InsuranceListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var products: [Product] = [] {
        didSet {
            self.myInsurancesViewPager.setProducts(products: products)
        }
    }
        
    var categories: [Category] = [] {
        didSet {
            UIView.transition(with: categoriesCollectionView, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.categoriesCollectionView.reloadData()
            }, completion: nil)
            self.myInsurancesViewPager.setCategories(categories: categories)
        }
    }
    
    var onProductSelect: ((Product?) -> Void)? = nil
    var onBack: (() -> Void)? = nil
    var selected: Int = 0
    
    private lazy var myInsurancesViewPager = InsuranceListViewPager(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    func setupUI() {
        categoriesCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: String(describing: CategoriesCell.self))
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        let flowLayout = (categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)
        flowLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout?.scrollDirection = .horizontal
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        self.findViewController()?.addChild(myInsurancesViewPager)
        self.contentView.addSubview(myInsurancesViewPager.view)
        self.myInsurancesViewPager.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.myInsurancesViewPager.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.myInsurancesViewPager.view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.myInsurancesViewPager.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.myInsurancesViewPager.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.myInsurancesViewPager.onPageChanged = { page in
            self.selected = page
            self.categoriesCollectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
            self.categoriesCollectionView.reloadData()
        }
        self.myInsurancesViewPager.onProductSelected = { product in
            self.onProductSelect?(product)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.onBack?()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoriesCell.self), for: indexPath) as! CategoriesCell
        cell.setData(category: categories[indexPath.row], isFirst: indexPath.row == 0, isSelected: selected == indexPath.row)
        cell.onCategoryClick = { cat in
//            self.onDocumentChanged?($0, indexPath.row)
            self.selected = indexPath.row
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.categoriesCollectionView.reloadData()
            let vc = self.myInsurancesViewPager.vcs[indexPath.row]
            self.myInsurancesViewPager.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
        return cell
    }
    
}

class CategoriesCell: UICollectionViewCell {
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    var category: Category!
    var onCategoryClick: ((Category) -> Void)? = nil
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
            borderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
        
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onItemClick(gestureRecognizer:))))
    }
    
    @objc
    private func onItemClick(gestureRecognizer: UITapGestureRecognizer) {
        onCategoryClick?(category)
    }
    
    func setData(category: Category, isFirst: Bool, isSelected: Bool) {
        self.leadingConstraint.constant = isFirst ? 31 : 5
        titleLabel.text = category.translates?[translatePosition]?.name
        self.category = category
        let color: UIColor = isSelected ? Colors.primaryGreen : Colors.pageIndicatorGray
        titleLabel.textColor = color
        self.borderView.layer.borderColor = color.cgColor
    }
}
