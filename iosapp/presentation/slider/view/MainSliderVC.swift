//
//  MainSliderVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import CHIPageControl

class MainSliderVC: BaseViewImpl {
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var pageControl: CHIPageControlAleppo!
    var pageViewController: PageVC! = nil
    private var openRegistration = false;
    
    lazy var sliderPresenter: SliderPresenterProtocol? = {
        return self.presenter as? SliderPresenterProtocol
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVC") as? PageVC
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.pageViewController)
        self.content.addSubview(self.pageViewController.view)
        NSLayoutConstraint.activate([
            self.pageViewController.view.leadingAnchor.constraint(equalTo: self.content.leadingAnchor),
            self.pageViewController.view.topAnchor.constraint(equalTo: self.content.topAnchor),
            self.pageViewController.view.trailingAnchor.constraint(equalTo: self.content.trailingAnchor),
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.content.bottomAnchor)
        ])
        
        self.pageControl.tintColor = Colors.pageIndicatorGray
        self.pageControl.currentPageTintColor = Colors.primaryGreen
        
        self.pageControl.progress = 0
        
        self.pageViewController.onPageChanged = { page in
            self.pageControl.set(progress: page, animated: true)
            self.openRegistration = page == 2
        }
        
    }
    
    @IBAction func onNextClicked(_ sender: Any) {
        if (self.openRegistration) {
            self.sliderPresenter?.nextButtonClicked()
        } else {
            self.pageViewController.goToNextPage()
        }
    }
    
    
    
}
