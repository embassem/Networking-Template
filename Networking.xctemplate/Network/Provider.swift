//
//  Provider.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import Alamofire

class APIProvider: NSObject {

    var provider: MoyaProvider<MultiTarget>!

    private let endpointClosure = { (target: MultiTarget) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)

        //.adding(newHTTPHeaderFields: ["X-Api-Key": apiKey])
        //.adding(newHTTPHeaderFields: ["accept-Language": Localize.currentLanguage()]);
        return defaultEndpoint

    }

    init(tokenCloser:@escaping (() -> String)) {
        self.provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure,
                                                  manager: DefaultAlamofireManager.sharedManager,
                                                  plugins: [
                                                    HeaderPlugin(keyClosure: "X-Api-Key", valueClosure: NetworkDefault.apiKey),
                                                    APPNetworkLoggerPlugin(verbose: NetworkDefault.verbose,
                                                                           cURL: false,
                                                                           responseDataFormatter: JSONResponseDataFormatter),
                                                    AppAccessTokenPlugin(tokenClosure: tokenCloser() )])
    }
}

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

extension MultiTarget: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType {
        // here you will have to check whether the `target` is also conforming to `AccessTokenAuthorizable` or not...
        if target is AccessTokenAuthorizable {
            guard let authTarget = target as? AccessTokenAuthorizable else {
                return .none
            }
            return authTarget.authorizationType
        }
        return .none
    }
}
