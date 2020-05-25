//
//  StoryboardModule.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class StoryboardModule: StoryboardModuleProtocol {
    lazy var main: UIStoryboard = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }()
}
