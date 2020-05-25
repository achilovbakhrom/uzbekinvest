//
//  BaseViewImpl.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class BaseViewImpl: UIViewController, BaseView {
    
    var presenter: BasePresenter? = nil
    
//    private var loadingView: LoadingView! = nil
//    private var loadingController: UIAlertController! = nil
    
    private var messageController: UIAlertController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loadingView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?[0] as? LoadingView
//        self.loadingController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
//        self.loadingController.view = loadingView
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showLoading() {
//        loadingView.startAnimating()
//        self.present(loadingController, animated: true, completion: nil)
    }
    
    func hideLoading() {
//        loadingView.stopAnimating()
//        self.dismiss(animated: true, completion: nil)
    }
    
    func showMessage(msg: String, title: String? = "Предуперждение!") {
        self.messageController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.messageController.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        self.present(self.messageController, animated: true, completion: nil)
    }
    
    func hideMessage() {
        self.dismiss(animated: true) { self.messageController = nil }
    }
    
    func showNetworkError() {
        
    }
    
    func hideNetworkError() {
        
    }
        
}
