//
//  RootVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class RootVC: BaseViewImpl {
    
    lazy var rootPresenter: RootPresenterProtocol? = {
        return self.presenter as? RootPresenterProtocol
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootPresenter?.initialCheck()        
    }
    
}
