//
//  DashboardView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var topViewHeight: CGFloat = UIScreen.main.bounds.height * 0.3

class DashboardVC: BaseViewImpl, BottomViewControllerScrollDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var dashboardPresenter = self.presenter as? DashboardPresenter
    
    var categories: [Category] = []
    
    let gcmMessageIDKey = "gcm.message_id"
    
    private var topMenuHeight: CGFloat {
        var topSpace: CGFloat = 0.0
        
        if isIPhone4OrNewer() {
            topSpace = 14.0
        } else if isIPhoneSE() {
            topSpace = 24.0
        } else if isIPhonePlus() {
            topSpace = 24.0
        } else {
            topSpace = 44.0
        }        
        return 0.05*UIScreen.main.bounds.height + topSpace;
    }
    
    private lazy var topMenu: UIView = {
        let view = UIView()
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var topMenuList: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        flow.scrollDirection = .horizontal
        return collection
    }()
    
    private lazy var centerMenuView: CenterMenuView = {
        let view = CenterMenuView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    private var selected = 0 {
        didSet {
            self.bottomViewController.goToPage(page: self.selected)
        }
    };
    
    private lazy var topViewController = TopViewController()
    
    private lazy var bottomViewController: BottomVC = {
        let vc = BottomVC()
        vc.delegate = self
        vc.productSelected = {
            self.dashboardPresenter?.openInsurance(product: $0)
        }
        vc.onPageChange = {
            self.topMenuList.scrollToItem(at: IndexPath(item: $0, section: 0), at: .centeredHorizontally, animated: true)
            self.selected = $0
            UIView.transition(with: self.topMenuList, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.topMenuList.reloadData()
            }, completion: nil)
        }
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewController(bottomViewController, frame: CGRect(x: 0, y: topMenuHeight, width: view.frame.size.width, height: view.frame.size.height - topMenuHeight), completion: nil)
        addViewController(topViewController, frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: topViewHeight + topMenuHeight), completion: nil)
        topViewController.onBell = {
            self.dashboardPresenter?.openNotifications()
        }
        self.setupTopMenu()
        self.setupCenterMenu()
        self.setupLoadingView()
        self.setupNoInternetView()
        
        let status = appDelegate.reach.connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showNoInternetView(show: true)
            break
        case .online(.wwan), .online(.wiFi):
            self.dashboardPresenter?.fetchCarouselData()
            self.dashboardPresenter?.fetchCategoryList()
            break
        }
        self.topViewController.onHeaderClick = { link in
            if let m = self.tabBarController as? MainViewController {
                m.handleLink(link: link, needReload: false)
            }
        }
        self.setupFirebase()
    }
    
    func setupFirebase() {
        
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        }
        
        
    }
    
    
    
    func setupNoInternetView() {
        self.view.addSubview(self.noInternetView)
        self.noInternetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noInternetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.noInternetView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noInternetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.noInternetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.view.bringSubviewToFront(self.noInternetView)
        self.noInternetView.layer.opacity = 0.0
        self.noInternetView.onRepeatClicked = {
            self.showNoInternetView(show: false)
            let status = self.appDelegate.reach.connectionStatus()
            switch status {
            case .unknown, .offline:
                self.showNoInternetView(show: true)
            case .online(.wwan):
                self.dashboardPresenter?.fetchCarouselData()
                self.dashboardPresenter?.fetchCategoryList()
            case .online(.wiFi):
                self.dashboardPresenter?.fetchCarouselData()
                self.dashboardPresenter?.fetchCategoryList()
            }
        }
        
    }
    
    func showNoInternetView(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.noInternetView.layer.opacity = show ? 1.0 : 0.0
        }
    }
    
    func setupLoadingView() {
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])        
        self.view.bringSubviewToFront(self.loadingView)
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            showLoading()
        } else {
            hideLoading()
        }
    }
    
    func setCarouselLoading(isLoading: Bool) {
        self.topViewController.setLoading(isLoading: isLoading)
    }
    
    func setCarouselList(carouselList: [Carousel]) {
        self.topViewController.setCarouselList(carouselList: carouselList)
    }
    
    override func showLoading() {
        self.loadingView.startAnimating()
        self.setTabBarHidden(true)
        UIView.animate(withDuration: 0.01, animations: {
            self.loadingView.layer.opacity = 1.0
        })
    }
    
    override func hideLoading() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingView.layer.opacity = 0.0
        }) { finished in
            if finished {
                self.loadingView.stopAnimating()
                self.setTabBarHidden(false)
            }
        }
    }
    
    func setProductList(productList: [Product]) {
        self.bottomViewController.setProductList(productList: productList)
    }
    
    func setCategoryList(categoryList: [Category]) {
        self.categories = categoryList
        self.topMenuList.reloadData()
        self.bottomViewController.categories = categoryList
    }
    
    func setupCenterMenu() {
        self.view.addSubview(self.centerMenuView)
        var coeff: CGFloat = 0.0
        
        if isIPhone4OrNewer() {
            coeff = 0.14
        } else if isIPhoneSE() {
            coeff = 0.13
        } else if isIPhonePlus() {
            coeff = 0.12
        } else {
            coeff = 0.11
        }        
        
        let height = self.view.bounds.height * coeff
        self.centerMenuTopContraint = self.centerMenuView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topViewHeight + topMenuHeight - height/2)
        
        NSLayoutConstraint.activate([
            self.centerMenuTopContraint!,
            self.centerMenuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.centerMenuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            self.centerMenuView.heightAnchor.constraint(equalToConstant: height)
        ])
        self.centerMenuView.onCheckOrder = { self.dashboardPresenter?.openCheckOrderVC() }
        self.centerMenuView.onIncident = { self.dashboardPresenter?.openIncidentsVC() }
        self.centerMenuView.onSupport = {
            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        self.view.bringSubviewToFront(self.centerMenuView)
    }
    
    var centerMenuTopContraint: NSLayoutConstraint? = nil
    
    func setupTopMenu() {
        self.view.addSubview(topMenu)
        self.topMenu.addSubview(self.topMenuList)
        self.topMenuList.register(TopMenuCell.self, forCellWithReuseIdentifier: "TopMenuCell")
        self.topMenuList.delegate = self
        self.topMenuList.dataSource = self
        
        NSLayoutConstraint.activate([
            topMenu.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topMenu.topAnchor.constraint(equalTo: self.view.topAnchor),
            topMenu.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topMenu.heightAnchor.constraint(equalToConstant: topMenuHeight)
        ])
        
        NSLayoutConstraint.activate([
            self.topMenuList.leadingAnchor.constraint(equalTo: self.topMenu.leadingAnchor),
            self.topMenuList.bottomAnchor.constraint(equalTo: self.topMenu.bottomAnchor),
            self.topMenuList.trailingAnchor.constraint(equalTo: self.topMenu.trailingAnchor),
            self.topMenuList.heightAnchor.constraint(equalToConstant: 0.05*UIScreen.main.bounds.height)
        ])
    }

    func bottomViewScrollViewDidScroll(_ scrollView: UIScrollView) {
        self.bottomViewController.setScrollOffset(offset: scrollView.contentOffset)
        let offset = (scrollView.contentOffset.y + topViewHeight)
        var coeff: CGFloat = 0.0
        
        if isIPhone4OrNewer() {
            coeff = 0.14
        } else if isIPhoneSE() {
            coeff = 0.13
        } else if isIPhonePlus() {
            coeff = 0.12
        } else {
            coeff = 0.11
        }
        let height = self.view.bounds.height * coeff
        centerMenuTopContraint?.constant = topViewHeight + topMenuHeight - height/2 - offset
                
        if offset > 60 {
            UIView.animate(withDuration: 0.3, animations: {
                self.centerMenuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.centerMenuView.layer.opacity = 0.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.centerMenuView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.centerMenuView.layer.opacity = 1.0
            })
        }
        
        if scrollView.contentOffset.y < 0 && abs(scrollView.contentOffset.y) < 25 {
            let opacity = (25.0 - abs(scrollView.contentOffset.y))/25.0
            self.topMenu.layer.opacity = Float(opacity)
        } else if scrollView.contentOffset.y >= 0 {
            self.topMenu.layer.opacity = Float(1)
        } else {
            self.topMenu.layer.opacity = Float(0)
        }
        if offset < 0 {
            topViewController.view.frame.origin.y = 0
            self.topViewController.view.frame.size.height = topViewHeight + self.topMenuHeight - offset
            self.topViewController.view.layoutIfNeeded()
        } else {
            topViewController.view.frame.origin.y = -(scrollView.contentOffset.y + topViewHeight)
            self.topViewController.view.frame.size.height = topViewHeight + self.topMenuHeight
            self.topViewController.view.layoutIfNeeded()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopMenuCell", for: indexPath) as! TopMenuCell
        cell.setTitle(title: categories[indexPath.item].translates?[translatePosition]?.name ?? "")
        if indexPath.row == selected {
            cell.select()
        } else {
            cell.unselect()
        }
        cell.onCellClick = {
            self.selected = indexPath.row
            self.topMenuList.reloadData()
        }
        return cell
    }    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = categories[indexPath.item].translates?[translatePosition]?.name ?? ""
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 0.05*UIScreen.main.bounds.height)
    }
    
}

protocol BottomViewControllerScrollDelegate: class {
    func bottomViewScrollViewDidScroll(_ scrollView: UIScrollView)
}

class BottomVC: UIViewController, UIScrollViewDelegate {
    
    var categories: [Category] = [] {
        didSet {
            self.setupContent()
        }
    }
    
    var onPageChange: ((Int) -> Void)? = nil
    var productList: [Product]  = []
    private var selectedIndex = 0
    weak var delegate: BottomViewControllerScrollDelegate?
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    var productSelected: ((Product?) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContent()
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.view.bounds.width
        selectedIndex = Int(scrollView.contentOffset.x/width)
    }
    
    func setProductList(productList: [Product]) {
        self.productList = productList
        self.children.forEach { ($0 as? BottomViewController)?.setProductList(productList: productList) }
    }
    
    public func setScrollOffset(offset: CGPoint) {
        var i = 0
        self.children.forEach {
            if i != self.selectedIndex {
                let vc = $0 as? BottomViewController
                if offset.y < 0 {
                    vc?.collectionView.contentOffset = offset
                } else {
                    vc?.collectionView.contentOffset.y = 0
                }
            }
            i += 1
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.onPageChange?(scrollView.currentPage)
    }
    
    func goToPage(page: Int) {
        self.scrollView.scrollTo(horizontalPage: page, animated: true)
    }
    
    private func setupContent() {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        self.scrollView.contentSize.width = width * CGFloat(self.categories.count > 0 ? self.categories.count : 1)
        self.scrollView.contentSize.height = height
        
        var index = 0
        
        (0..<categories.count).forEach {
            let vc = BottomViewController()
            vc.category = categories[$0]
            vc.productSelected = productSelected
            vc.delegate = self.delegate
            self.addChild(vc)
            self.scrollView.addSubview(vc.view)
            vc.view.frame = CGRect(x: CGFloat(index) * width, y: 0.0, width: width, height: height)
            index += 1
        }

    }
}

class BottomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
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
        collectionView.contentInset.top = topViewHeight
        collectionView.scrollIndicatorInsets.top = topViewHeight
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: String(describing: MenuCell.self))
        collectionView.register(EmptyMenuCell.self, forCellWithReuseIdentifier: String(describing: EmptyMenuCell.self))
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count >= 6 ? productList.count : 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if productList.count >= 6 || (productList.count < 6 && indexPath.row <= productList.count-1)  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuCell.self), for: indexPath) as! MenuCell
            cell.setData(model: self.productList[indexPath.row], index: indexPath.row, isLast: indexPath.row == productList.count - 1)
            cell.cellClicked = { self.productSelected?($0) }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyMenuCell.self), for: indexPath) as! EmptyMenuCell
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.bottomViewScrollViewDidScroll(scrollView)
    }
}
