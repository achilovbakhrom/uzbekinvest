//
//  LocationVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class LocationVC: BaseViewImpl {
    
    private lazy var locationView: LocationView = LocationView.fromNib()
    private var pagerVC: LocationPagerVC!
    private var incdidentPresenter: IncidentsAddEditPresenter? {
        get {
            return self.presenter as? IncidentsAddEditPresenter
        }
    }
    
    var orderId: Int = 0
    var productCode: String = ""
    var isOffline: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(locationView)
        NSLayoutConstraint.activate([
            self.locationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.locationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.locationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.locationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.locationView.onBackClicked = {
            self.incdidentPresenter?.goBack()
        }
        self.locationView.nextButton.isEnabled = false
        self.locationView.onNext = {
            self.incdidentPresenter?.openReasonVC()
        }
        pagerVC = LocationPagerVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pagerVC.onLocationChange = {
            self.incdidentPresenter?.setLongLat(long: $0, lat: $1)
        }
        
        pagerVC.onAddressChange = {
            self.incdidentPresenter?.setAddress(address: $0)
        }
        
        pagerVC.onPageChanged = {
            let isMapMode = $0 == 0
            self.locationView.setMode(isMapMode: isMapMode)
            self.incdidentPresenter?.setMode(isMapMode: isMapMode)
        }
        
        self.addChild(pagerVC)
        self.locationView.contentView.addSubview(pagerVC.view)
        
        NSLayoutConstraint.activate([
            pagerVC.view.leadingAnchor.constraint(equalTo: self.locationView.contentView.leadingAnchor),
            pagerVC.view.topAnchor.constraint(equalTo: self.locationView.contentView.topAnchor),
            pagerVC.view.trailingAnchor.constraint(equalTo: self.locationView.contentView.trailingAnchor),
            pagerVC.view.bottomAnchor.constraint(equalTo: self.locationView.contentView.bottomAnchor)
        ])
        
        self.locationView.onModeChanged = { isMapMode in
            if isMapMode {
                self.pagerVC.goToPrevPage()
            } else {
                self.pagerVC.goToNextPage()
            }
        }
        
        self.locationView.onInfo = {
            let vc = InfoVC()
            vc.text = self.instruction
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        self.incdidentPresenter?.orderId = orderId
        self.incdidentPresenter?.productCode = productCode
        self.incdidentPresenter?.fetchIncidentMetaDataForInfo()
        self.incdidentPresenter?.setIsOffline(isOffline: self.isOffline)
        self.locationView.setMode(isMapMode: true)
        self.incdidentPresenter?.setMode(isMapMode: true)
        
    }
    
    func setEnabled(isEnabled: Bool) {
        self.locationView.nextButton.isEnabled = isEnabled
    }
    var instruction = ""
    func setInfo(text: String) {
        self.locationView.infoButton.isHidden = text.isEmpty
        self.instruction = text        
    }
}

class LocationPagerVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var onPageChanged: ((Int) -> Void)? = nil
    var locationsList: Array<Office> = []
    
    var onAddressChange: ((String) -> Void)? = nil
    var onLocationChange: ((Double, Double) -> Void)? = nil
    
    private lazy var vcs: [UIViewController] = {
        let mapVC = IncidentLocationMapVC()
        mapVC.onLocationChange = onLocationChange
        let addressVC = IncidentAddressVC()
        addressVC.onAddressChange = self.onAddressChange
        return [mapVC, addressVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        if let firstViewController = vcs.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func setOfficesList(officesList: Array<Office>) {
        self.locationsList = officesList
        if let vc = self.viewControllers?[0] as? OfficesListVC {
            vc.setOfficesList(officesList: officesList)
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
        let vc = vcs[previousIndex]
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
        let vc = vcs[nextIndex]
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
        let index = vcs.firstIndex(of: firstViewController) {
            self.onPageChanged?(index)
        }
    }
    
}
