//
//  NetworkManager.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

let serverTrustPolicies: [String: ServerTrustPolicy] = [
    "http://62.209.128.56": .disableEvaluation
]

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
    public init() {
        super.init(policies: serverTrustPolicies)
    }
    
}

struct NetworkManager {
    
    var tokenFactory: TokenFactory
    var authPlugin: AuthPlugin
    var auth: MoyaProvider<AuthProvider>
    var insurance: MoyaProvider<InsuranceProvider>
    var user: MoyaProvider<UserProvider>
    var incident: MoyaProvider<IncidentsProvider>
    var callRequest: MoyaProvider<CallRequestProvider>
    var exportOperation: MoyaProvider<ExportOperationsProvider>
    var insuranceReminder: MoyaProvider<InsuranceReminderProvider>
    var regions: MoyaProvider<RegionsProvider>
    var others: MoyaProvider<OthersProvider>
    var orders: MoyaProvider<OrderProvider>
    var transport: MoyaProvider<TransportProvider>
    var product: MoyaProvider<ProductProvider>    
    var networkLoggingPlugin: NetworkLoggerPlugin
    
    init(tokenFactory: TokenFactory) {
        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        
        self.tokenFactory = tokenFactory
        authPlugin = AuthPlugin(tokenClosure: { () -> String? in tokenFactory.getToken() })
        networkLoggingPlugin = NetworkLoggerPlugin()
        
        auth = MoyaProvider(manager: manager, plugins: [networkLoggingPlugin])
        insurance = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        user = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        incident = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        callRequest = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        exportOperation = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        insuranceReminder = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        regions = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        others = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        orders = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        transport = MoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        product = MoyaProvider(manager: manager, plugins: [networkLoggingPlugin])
    }
}

