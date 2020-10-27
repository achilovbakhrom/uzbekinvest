//
//  Orders.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum OrderProvider {
    case osagoCalculate(osago: Osago)
    case pledgedTransportCalculate(pledgedTransport: PledgedTransport)
    case kaskoCalculate(kasko: Kasko)
    case homeCalculate(home: Home)
    case ipotekaCalculate(pledgedProperty: PledgedProperty)
    case myHealth(health: MyHealth)
    case medicalCalculate(medical: MedicalInsurance)
    case sportCalculate(sport: Sport)
    case technicalSupportCalculate(technicalSupport: TechnicalSupport)
    case gasHomeCalculate(gasHome: GasHome)
    case gasAutoCalculate(gasHome: GasAuto)
    case infectionCalculate(infection: Infection)
    case phoneCalculate(mobilePhone: MobilePhone)
    case luggageCalculate(luggage: Luggage)
    case checkOrder(seria: String, number: Int)
    case createInsurance(url: String, params: [String: Any], amount: Int?, startDate: String, paymentType: String, regionId: Int, mainFiles: [Int: UserFile], membersCount: Int, secondaryFils: [Int: [Int: UserFile]]? = nil, long: Double, lat: Double)
    case travelCalculate(travel: Travel)
    case payme(orderId: Int)
    case click(orderId: Int)
}

extension OrderProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .osagoCalculate:
            return "api/order/osago/calculate"
        case .pledgedTransportCalculate:
            return "api/order/pledged-transport/calculate"
        case .kaskoCalculate:
            return "api/order/kasko/calculate"
        case .homeCalculate:
            return "api/order/my-home/calculate"
        case .ipotekaCalculate:
            return "api/order/pledged-property/calculate"
        case .myHealth:
            return "api/order/my-health/calculate"
        case .medicalCalculate:
            return "api/order/medical-insurance/calculate"
        case .sportCalculate:
            return "api/order/sport/calculate"
        case .technicalSupportCalculate:
            return "api/order/technical-help/calculate"
        case .travelCalculate:
            return "api/order/travel/calculate"
        case .gasHomeCalculate:
            return "api/order/gas-home/calculate"
        case .gasAutoCalculate:
            return "api/order/gas-auto/calculate"
        case .infectionCalculate:
            return "api/order/disease/calculate"
        case .phoneCalculate:
            return "api/order/phone/calculate"
        case .luggageCalculate:
            return "api/order/luggage-out/calculate"
        case .createInsurance(let url, _, _, _, _, _, _, _, _, _, _):
            return "api/order/\(url)"
        case .checkOrder:
            return "api/order/check"
        case .payme(let orderId):
            return "api/user/order/\(orderId)/payme"
        case .click(let orderId):
            return "api/user/order/\(orderId)/click"
        
        }
    }
    var method: Method {
        switch self {
        case .payme, .click:
            return .get
        default:
            return .post
        }
        
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .osagoCalculate(let osago):            
            return .requestParameters(parameters: osago.dictionary!, encoding: JSONEncoding.default)
        case .pledgedTransportCalculate(let pledgedTransport):
            return .requestParameters(parameters: pledgedTransport.dictionary!, encoding: JSONEncoding.default)
        case .kaskoCalculate(let kasko):
            return .requestParameters(parameters: kasko.dictionary!, encoding: JSONEncoding.default)
        case .homeCalculate(let home):
            return .requestParameters(parameters: home.dictionary!, encoding: JSONEncoding.default)
        case .ipotekaCalculate(let pledgedProperty):
            return .requestParameters(parameters: pledgedProperty.dictionary!, encoding: JSONEncoding.default)
        case .travelCalculate(let travel):
            return .requestParameters(parameters: travel.dictionary!, encoding: JSONEncoding.default)
        case .myHealth(let health):
            return .requestParameters(parameters: health.dictionary!, encoding: JSONEncoding.default)
        case .medicalCalculate(let medical):
            return .requestParameters(parameters: medical.dictionary!, encoding: JSONEncoding.default)
        case .sportCalculate(let sport):
            return .requestParameters(parameters: sport.dictionary!, encoding: JSONEncoding.default)
        case .technicalSupportCalculate(let technicalSupport):
            return .requestParameters(parameters: technicalSupport.dictionary!, encoding: JSONEncoding.default)
        case .gasHomeCalculate(let gasHome):
            return .requestParameters(parameters: gasHome.dictionary!, encoding: JSONEncoding.default)
        case .gasAutoCalculate(let gasAuto):
            return .requestParameters(parameters: gasAuto.dictionary!, encoding: JSONEncoding.default)
        case .infectionCalculate(let infection):
            return .requestParameters(parameters: infection.dictionary!, encoding: JSONEncoding.default)
        case .phoneCalculate(let mobilePhone):
            return .requestParameters(parameters: mobilePhone.dictionary!, encoding: JSONEncoding.default)
        case .luggageCalculate(let luggage):
            return .requestParameters(parameters: luggage.dictionary!, encoding: JSONEncoding.default)
        case .checkOrder(let seria, let number):
            return .requestParameters(parameters: ["seria" : seria, "number": number], encoding: JSONEncoding.default)
        case .payme:
            return .requestPlain
        case .click:
            return .requestPlain
        case .createInsurance(_, let params, let amount, let startDate, let paymentType, let regionId, let mainFiles, let membersCount, let secondaryFils, let long, let lat):
            var p = [MultipartFormData]()
            for key in params.keys {
                let data = MultipartFormData(provider: .data(String(describing: params[key]!).data(using: .utf8) ?? Data()), name: key)
                p.append(data)
            }
            if let a = amount {
                p.append(MultipartFormData(provider: .data(String(describing: a).data(using: .utf8) ?? Data()), name: "insurance_amount"))
            }
            p.append(MultipartFormData(provider: .data(startDate.data(using: .utf8) ?? Data()), name: "start_date"))
            p.append(MultipartFormData(provider: .data(String(describing: paymentType).data(using: .utf8) ?? Data()), name: "payment_method"))
            p.append(MultipartFormData(provider: .data(String(describing: regionId).data(using: .utf8) ?? Data()), name: "region_id"))
            p.append(MultipartFormData(provider: .data(String(describing: long).data(using: .utf8) ?? Data()), name: "longitude"))
            p.append(MultipartFormData(provider: .data(String(describing: lat).data(using: .utf8) ?? Data()), name: "latitude"))
            p.append(MultipartFormData(provider: .data("mobile".data(using: .utf8) ?? Data()), name: "platform"))
            var index = 0
            for key in mainFiles.keys {
                p.append(MultipartFormData(provider: .data(String(describing: mainFiles[key]?.id ?? 0).data(using: .utf8) ?? Data()), name: "files[0][\(index)][name]"))
                p.append(MultipartFormData(provider: .data(String(describing: key).data(using: .utf8) ?? Data()), name: "files[0][\(index)][document_id]"))
                index += 1
            }
            if membersCount >= 1 {
                for key in (secondaryFils ?? [:]).keys {
                    index = 0
                    for k in (secondaryFils?[key] ?? [:]).keys {
                        p.append(MultipartFormData(provider: .data(String(describing: secondaryFils?[key]?[k]?.id ?? 0).data(using: .utf8) ?? Data()), name: "files[\(key+1)][\(index)][name]"))
                        p.append(MultipartFormData(provider: .data(String(describing: k).data(using: .utf8) ?? Data()), name: "files[\(key+1)][\(index)][document_id]"))
                        index += 1
                    }
                }
            }                        
            return .uploadMultipart(p)            
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .createInsurance:
            return [
                "Content-Type": "multipart/form-data",
                "Accept": "application/json"                
            ]
        default:
            return ["Content-Type": "application/json"]
        }
        
    }
    
    
}
