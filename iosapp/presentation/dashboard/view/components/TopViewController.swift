//
//  TopViewController.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/22/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import CHIPageControl

class TopViewController: UIViewController {
    
    private lazy var carouselBigImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "carousel_big_circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var carouselSmallImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "carousel_small_circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bellButton: UIButton = {
        let button = UIButton.init()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(named: "bell"), for: .normal)
        return button
    }()
    
    private lazy var carouselBgImageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var carouselList = [Carousel]()
    
    var onBell: (() -> Void)? = nil
    
    var onHeaderClick: ((String) -> Void)? = nil
    
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    private lazy var pageControl: CHIPageControlAleppo = {
        let control = CHIPageControlAleppo(frame: .zero)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.tintColor = .white
        control.currentPageTintColor = .white
        control.progress = 0
        control.padding = 10
        control.radius = 1.0
        return control
    }()
    
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
    
    var carousel: CarouselViewController = CarouselViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var grandient: CAGradientLayer!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if grandient != nil {
            self.grandient.frame = self.view.bounds
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.carouselBgImageView)
        NSLayoutConstraint.activate([
            self.carouselBgImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.carouselBgImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.carouselBgImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.carouselBgImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.carouselBgImageView.backgroundColor = Colors.primaryGreen
        
        grandient = CAGradientLayer()
        grandient.makeGray()
        self.view.layer.addSublayer(grandient)
        
        self.addChild(carousel)
        self.view.addSubview(carousel.view)
        NSLayoutConstraint.activate([
            self.carousel.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.carousel.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.carousel.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.carousel.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        var bottomMargin: CGFloat = 0.0
        if isIPhone4OrNewer() {
            bottomMargin = -50.0
            self.pageControl.radius = 3.0
            self.pageControl.padding = 6.0
        } else if isIPhoneSE() {
            self.pageControl.radius = 3.0
            self.pageControl.padding = 8.0
            bottomMargin = -50
        } else if isIPhonePlus() {
            self.pageControl.radius = 3.0
            self.pageControl.padding = 10.0
            bottomMargin = -60.0
        } else {
            self.pageControl.radius = 3.0
            self.pageControl.padding = 10.0
            bottomMargin = -60.0
        }
        self.view.addSubview(self.pageControl)
        NSLayoutConstraint.activate([
            self.pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31),
            self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: bottomMargin),
            self.pageControl.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
            self.pageControl.heightAnchor.constraint(equalToConstant: 10.0)
        ])
        
        
        self.view.addSubview(bellButton)
        NSLayoutConstraint.activate([
            self.bellButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -31),
            self.bellButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45)
        ])
        bellButton.addTarget(self, action: #selector(onBellAction(_:)), for: .touchUpInside)
        self.carousel.onPageChanged = { page in
            self.pageControl.set(progress: page, animated: true)
            if let url = URL(string: "\(BASE_URL)\(self.carouselList[page].image ?? "")") {
                self.carouselBgImageView.kf.setImage(with: url, placeholder: nil, options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage,
                    .forceTransition
                ])
            }
        }
        self.loadingView.startAnimating()
        carousel.onHeader = { self.onHeaderClick?($0) }
    }
    
    @objc
    private func onBellAction(_ sender: Any) {
        self.onBell?()
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
    }
    
    func setCarouselList(carouselList: [Carousel]) {
        self.carouselList = carouselList
        
        if !self.carouselList.isEmpty, let url = URL(string: "\(BASE_URL)\(self.carouselList[0].image ?? "")") {
            self.carouselBgImageView.kf.setImage(with: url, placeholder: nil, options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage,
                .forceTransition
            ])
        }
        self.carousel.setCarouselList(carouselList: carouselList)
        self.pageControl.numberOfPages = carouselList.count
    }
    
}

class CarouselViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
    }
    var onHeader: ((String) -> Void)? = nil
    
    private(set) var vcs: [UIViewController] = [UIViewController(), UIViewController()]
    
    var onPageChanged: ((_ page: Int) -> Void)?
    
    func setCarouselList(carouselList: [Carousel]) {        
        vcs.removeAll()
        carouselList.forEach {
            let vc = TopContentViewController()
            $0.translates?.forEach({ t in
                if t?.lang == translateCode {
                    vc.topView.headerTitleLabel.text = t?.title
                    vc.topView.headerContentLabel.text = t?.description
                }
            })
//            vc.topView.headerTitleLabel.text = ($0.translates?.count ?? 0) > 0 ? $0.translates?.reversed()[0]?.title : "-"
//            vc.topView.headerContentLabel.text = ($0.translates?.count ?? 0) > 0 ? $0.translates?.reversed()[0]?.description : "-"
            vc.topView.headerContentLabel.isUserInteractionEnabled = true
            let t = $0
            vc.topView.onHeaderClick = {
                t.translates?.forEach({ (t) in
                    if t?.lang == translateCode {
                        self.onHeader?(t?.url ?? "")
                    }
                })                
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
        return vcs[previousIndex]
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
        
        return vcs[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
        if let firstViewController = viewControllers?.first, let index = vcs.firstIndex(of: firstViewController) {
            self.onPageChanged?(index)
        }
    }
}


class TopContentViewController: UIViewController {
    
    var topView: MainView = {
        let view = MainView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var topMargin: CGFloat = 0.0
        var bottomMargin: CGFloat = 0.0
        if isIPhone4OrNewer() {
            topMargin = 20.0
            bottomMargin = -80
        } else if isIPhoneSE() {
            topMargin = 35.0
            bottomMargin = -100
        } else if isIPhonePlus() {
            topMargin = 45.0
            bottomMargin = -120
        } else {
            topMargin = 65.0
            bottomMargin = -120
        }
        
        self.view.addSubview(topView)
        NSLayoutConstraint.activate([
            self.topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: topMargin),
            self.topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.topView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: bottomMargin)
        ])
    }
    
    
}
