//
//  AppAccessToken.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya

public struct AppAccessTokenPlugin: PluginType {

    /// A closure returning the access token to be applied in the header.
    public let tokenClosure: () -> String

    /**
     Initialize a new `AccessTokenPlugin`.

     - parameters:
     - tokenClosure: A closure returning the token to be applied in the pattern `Authorization: <AuthorizationType> <token>`
     */
    public init(tokenClosure: @escaping @autoclosure () -> String) {
        self.tokenClosure = tokenClosure
    }

    /**
     Prepare a request by adding an authorization header if necessary.

     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let authorizable = target as? AccessTokenAuthorizable else { return request }

        let authorizationType = authorizable.authorizationType

        var request = request
        let token = tokenClosure()
        if (token.isEmpty) {
            return request
        }
        switch authorizationType {
        case .basic, .bearer:
            let authValue = authorizationType.rawValue + " " + tokenClosure()
            request.addValue(authValue, forHTTPHeaderField: "Authorization")
        case .none:
            break
        }

        return request
    }
}
