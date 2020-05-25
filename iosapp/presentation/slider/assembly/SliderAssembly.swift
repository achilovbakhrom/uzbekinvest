//
//  SliderAssembly.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol SliderAssemblyProtocol: BaseAssemblyProtocol {
    var mainStoryboard: UIStoryboard { get set }
    init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory)
}

class SliderAssembly: SliderAssemblyProtocol {
    
    var mainStoryboard: UIStoryboard
    var serviceFactory: ServiceFactoryProtocol
    var factory: AssemblyFactory
    
    required init(serviceFactory: ServiceFactoryProtocol, storyboard: UIStoryboard, assemblyFactory: AssemblyFactory) {
        self.serviceFactory = serviceFactory
        self.mainStoryboard = storyboard
        self.factory = assemblyFactory
    }
    
    func assembleViewController() -> UIViewController? {
        let presenter = SliderPresenter()
        let router = SliderRouter()
        router.factory = self.factory
        let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "MainSliderVC") as? MainSliderVC
        presenter.router = router
        router.viewController = vc
        vc?.presenter = presenter
        return vc
    }
}
