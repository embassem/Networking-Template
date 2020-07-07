//
//  NetworkManager.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//
import Foundation
import Moya

/// Closure to be executed when a request has completed.
typealias StatusCode = Int
typealias MoyaCompletion =
    (Result<Moya.Response, MoyaError>)
typealias NetworkComplation<T:Codable> =
    (_ result: Swift.Result<APIResponse<T>, APIError>, _ statusCode: StatusCode?) -> Void

class NetworkManager {
    
    static let shared: NetworkManager = { NetworkManager(config: .defaults)}()
    
    var networkConfig: NetworkDefaults!
    
    let provider: MoyaProvider<MultiTarget>
    

    init(config: NetworkDefaults = NetworkDefaults.defaults) {
        self.networkConfig = config
        
        let headerPlugin = StaticHeaderPlugin(
            headers: [:])
        
        
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        provider = MoyaProvider<MultiTarget>(//manager: ,
            plugins: [headerPlugin, NetworkLoggerPlugin(configuration: loggerConfig),
                      AccessTokenPlugin(tokenClosure: accessToken)])
    }
    
    var accessToken :((AuthorizationType) -> String) =  { _ in
        
        return PersistenceManager.getUserTokenAuth()?.accessToken ?? ""
    }
    
}
