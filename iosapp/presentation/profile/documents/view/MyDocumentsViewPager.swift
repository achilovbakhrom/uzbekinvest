//
//  MyDocumentsViewPager.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/17/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyDocumentsViewPager: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var onPageChanged: ((Int) -> Void)? = nil
    var userFiles: Array<UserFile> = []
    var documents: [Document] = []
    var onRemove: ((Int) -> Void)? = nil
    var onUpload: ((Int) -> Void)? = nil
    var vcs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
    }
    
    func setUserFiles(userFiles: Array<UserFile>) {
        self.userFiles = userFiles
        var index = 0
        documents.forEach { doc in
            let vc = vcs[index] as! MyDocumentsContentVC
            vc.userFiles = userFiles.filter { doc.id == $0.document?.id }
            index += 1
        }
    }
    
    func setDocuments(documents: [Document]) {
        self.documents = documents
        documents.forEach { doc in
            let vc = MyDocumentsContentVC()
            vc.userFiles = userFiles.filter { doc.id == $0.document?.id }
            vc.onRemove = { self.onRemove?($0) }
            vc.onUpload = { self.onUpload?(doc.id) }
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
        let doc = documents[previousIndex]
        let vc = vcs[previousIndex] as! MyDocumentsContentVC
        vc.userFiles = userFiles.filter { doc.id == $0.document?.id }
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
        let doc = documents[nextIndex]
        let vc = vcs[nextIndex] as! MyDocumentsContentVC
        vc.userFiles = userFiles.filter { doc.id == $0.document?.id }
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
