//
//  OfficesViewPagerVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class OfficesViewPagerVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var onPageChanged: ((Int) -> Void)? = nil
    var officesList: Array<Office> = []
    
    private lazy var vcs: [UIViewController] = [OfficesListVC(), OfficesMapVC()]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        delegate = self
        dataSource = self
        if let firstViewController = vcs.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func setOfficesList(officesList: Array<Office>) {
        self.officesList = officesList
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
        let vc = vcs[previousIndex] as! OfficesListVC
        vc.setOfficesList(officesList: self.officesList)
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
        let vc = vcs[nextIndex] as! OfficesMapVC
        vc.setOfficesList(officesList: self.officesList)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
        let index = vcs.firstIndex(of: firstViewController) {
            self.onPageChanged?(index)
        }
    }
    
}
