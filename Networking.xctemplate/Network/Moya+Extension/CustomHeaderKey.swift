//
//  CustomHeaderKey.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Moya

public struct HeaderPlugin: PluginType {

    /// A closure returning the access token to be applied in the header.
    public let valueClosure: () -> String

    public let keyClosure: () -> String
    /**
     Initialize a new `AccessTokenPlugin`.

     - parameters:
     - tokenClosure: A closure returning the token to be applied in the pattern `Authorization: <AuthorizationType> <token>`
     */
    public init(keyClosure: @escaping @autoclosure () -> String, valueClosure: @escaping @autoclosure () -> String) {
        self.valueClosure = valueClosure
        self.keyClosure = keyClosure
    }

    /**
     Prepare a request by adding an authorization header if necessary.

     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request

        request.addValue(valueClosure(), forHTTPHeaderField: keyClosure())
        return request
    }
}
