//
//  MyCategoriesViewPager.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit


class InsuranceListViewPager: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var onPageChanged: ((Int) -> Void)? = nil
    var products: Array<Product> = []
    var categories: [Category] = []
    var onRemove: ((Int) -> Void)? = nil
    var onUpload: ((Int) -> Void)? = nil
    var vcs: [UIViewController] = []
    var onProductSelected: ((Product?) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
    }
    
    func setProducts(products: Array<Product>) {
        self.products = products
        var index = 0
        categories.forEach { cat in
            let vc = vcs[index] as! InsuranceListSingleVC
            if cat.id == -1 {
                vc.setProductList(productList: self.products)
            } else {
                vc.setProductList(productList: self.products.filter({ product in
                    return product.category?.id == cat.id
                }))
            }
            
            vc.productSelected = { product in
                self.onProductSelected?(product)
            }
            index += 1
        }
    }
    
    func setCategories(categories: [Category]) {
        self.categories = categories
        categories.forEach { cat in
            let vc = InsuranceListSingleVC()
            vc.setProductList(productList: self.products.filter({ product in
                return product.category?.id == cat.id
            }))
            vc.productSelected = { product in
                self.onProductSelected?(product)
            }
            vcs.append(vc)
        }
        if let firstViewController = vcs.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = vcs.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard vcs.count > previousIndex else {
            return nil
        }
        let cat = categories[previousIndex]
        let vc = vcs[previousIndex] as! InsuranceListSingleVC
        if cat.id == -1 {
            vc.setProductList(productList: self.products)
        } else {
            vc.setProductList(productList: self.products.filter({ product in
                return product.category?.id == cat.id
            }))
        }
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = vcs.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = vcs.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        let cat = categories[nextIndex]
        let vc = vcs[nextIndex] as! InsuranceListSingleVC
        if cat.id == -1 {
            vc.setProductList(productList: self.products)
        } else {
            vc.setProductList(productList: self.products.filter({ product in
                return product.category?.id == cat.id
            }))
        }
        return vc
    }
    
    var currentIndex = 0
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
        let index = vcs.firstIndex(of: firstViewController) {
            self.currentIndex = index
            self.onPageChanged?(index)
        }
    }
    
}


class InsuranceListSingleVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var collectionView: UICollectionView!
    weak var delegate: BottomViewControllerScrollDelegate?
    private var productList: [Product] = []
    
    var productSelected: ((Product?) -> Void)? = nil
    var category: Category? = nil
    
    func setProductList(productList: [Product]) {
        if let c = self.category, c.id != -1 {
            self.productList = productList.filter({ ($0.category?.id ?? 0) == c.id })
        } else {
            self.productList = productList
        }
        if collectionView != nil {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutSubviews()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: String(describing: MenuCell.self))
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuCell.self), for: indexPath) as! MenuCell
        cell.setData(model: self.productList[indexPath.row], index: indexPath.row, isLast: indexPath.row == productList.count - 1, isFromDashboard: false, isOdd: indexPath.row % 2 == 0)
        cell.cellClicked = {
            self.productSelected?($0)
        }
        return cell
    }
    
    
}
