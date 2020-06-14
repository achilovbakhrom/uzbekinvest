//
//  OthersProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum OthersProvider {
    case news
    case faq
    case carousel
    case country
    case payme(payme: Payme)
    case click(click: Click)
    case translate
    case address
    case transport
    case sports
    case fetchCategoryList
    case fetchCarouselData
    case work
}

extension OthersProvider: TargetType {
    
    var baseURL: URL { return URL(string: BASE_URL)! }
    
    var path: String {
        switch self {
        case .news:
            return "/api/news"
        case .faq:
            return "/api/question"
        case .carousel:
            return "/api/v2/carousel"
        case .country:
            return "/api/country"
        case .payme:
            return "/api/payment/payme"
        case .click:
            return "/api/payment/click"
        case .translate:
            return "/api/translate"
        case .address:
            return "/api/v2/translate"
        case .transport:
            return "/get/transport"
        case .sports:
            return "/api/sport"
        case .work:
            return "/api/work"
        case .fetchCategoryList:
            return "/api/category"
        case .fetchCarouselData:
            return "/api/carousel/active"
        }
    }
    
    var method: Method {
        switch self {
        case .payme, .click:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .news:
            return .requestPlain
        case .faq:
            var lang = "ru"
            switch translatePosition {
            case 0:
                lang = "ru"
                break
            case 1:
                lang = "uz"
                break
            case 2:
                lang = "oz"
                break
            default:
                lang = "ru"
                break
            }
            return .requestParameters(parameters: ["lang" : lang], encoding: URLEncoding.default)
        case .carousel:
            return .requestPlain
        case .country:
            return .requestPlain
        case .payme(let payme):
            return .requestParameters(parameters: payme.dictionary!, encoding: JSONEncoding.default)
        case .click(let click):
            return .requestParameters(parameters: click.dictionary!, encoding: JSONEncoding.default)
        case .translate:
            return .requestPlain
        case .address:
            return .requestPlain
        case .transport:
            return .requestPlain
        case .sports:
            return .requestPlain
        case .work:
            return .requestPlain
        case .fetchCategoryList:
            return .requestPlain
        case .fetchCarouselData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
