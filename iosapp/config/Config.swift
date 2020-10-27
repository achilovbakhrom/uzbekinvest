//
//  Config.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

enum Mode {
    case development, production
}

#if DEBUG
    let mode = Mode.development
#else
    let mode = Mode.production
#endif

//var BASE_URL = "https://test.insurance.uz"
var BASE_URL = "https://api.insurance.uz"
//var BASE_URL = "http://62.209.128.56"

public func isIPhone4OrNewer() -> Bool {
    let deviceType = UIDevice.current.screenType;
    switch deviceType {
    case .iPhones_5_5s_5c_SE, .iPhones_4_4S:
        return true
    default:
        return false
    }
}

public func isIPhoneSE() -> Bool {
    let deviceType = UIDevice.current.screenType;
    switch deviceType {
    case .iPhones_6_6s_7_8:
        return true
    default:
        return false
    }
}

public func isIPhonePlus() -> Bool {
    let deviceType = UIDevice.current.screenType;
    switch deviceType {
    case .iPhones_6Plus_6sPlus_7Plus_8Plus:
        return true
    default:
        return false
    }
}

public func isIPhoneX() -> Bool {
    let deviceType = UIDevice.current.screenType;
    switch deviceType {
    case .iPhones_X_XS:
        return true
    default:
        return false
    }
}


public func isIPhoneXOrHigher() -> Bool {
    let deviceType = UIDevice.current.screenType;
    switch deviceType {
    case .iPhone_XR_11, .iPhone_XSMax_ProMax, .iPhone_11Pro:
        return true
    default:
        return false
    }
}

public var translatePosition: Int {
    get {
        let lang = UserDefaults.standard.string(forKey: "language") ?? "ru"
        switch lang {
        case "ru":
            return 0
        case "uz-UZ":
            return 1
        case "uz-Cyrl":
            return 2;
        default:
            return 0
        }
    }
}

public var translateCode: String {
    get {
        let lang = UserDefaults.standard.string(forKey: "language") ?? "ru"
        switch lang {
        case "ru":
            return "ru"
        case "uz-UZ":
            return "uz"
        case "uz-Cyrl":
            return "oz";
        default:
            return "ru"
        }
    }
}


// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
class L102Language {
    
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}

let phoneNumber = "712076000"

