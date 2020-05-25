//
//  IncidentsProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum IncidentsProvider {
    case incidents(incident: Incident)
    case fetchAllIncidents
    case createIncident(incident: Incident, files: [String: Data])
}

extension IncidentsProvider: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .incidents:
            return "/api/user/incident"
        case .fetchAllIncidents:
            return "/api/user/incident"
        case .createIncident:
            return "/api/incident"
        }
        
        
    }
    
    var method: Method {
        switch self {
        case .incidents:
            return .post
        case .fetchAllIncidents:
            return .get
        case .createIncident:
            return .post
        }
        
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .incidents(let incident):
            return .requestParameters(parameters: incident.dictionary!, encoding: JSONEncoding.default)
        case .fetchAllIncidents:
            return .requestPlain
        case .createIncident(let incident, let files):
            var p: [MultipartFormData] = []
            let inc = incident.dictionary!
            for key in inc.keys {
                p.append(
                    MultipartFormData(provider: .data(String(describing: inc[key]!).data(using: .utf8)!), name: key)
                )
            }
            
            
            for key in files.keys {
                p.append(MultipartFormData(provider: .data(files[key]!), name: key, fileName: "file.jpeg", mimeType: "image/png"))
            }
            
            return .uploadCompositeMultipart(p, urlParameters: incident.dictionary!)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createIncident:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }        
    }
    
    
}
