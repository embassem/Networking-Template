//
//  NetworkService.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

//TODO: List
// - Cancelable
// hock to response to check on failure

import Foundation
import Alamofire
import Moya
import ObjectMapper
import SwiftyJSON
import Moya_ObjectMapper
//import Reachability
import enum Result.Result
import Models
//typealias NetworkServiceResponse = ( _ model: Mappable?,  _ error:Swift.Error?, _ data: JSON?, _ response: Response?  ) -> Void;

//============================================================================
//============================================================================
// MARK: - typealias

public typealias NetworkResponseResult = NetworkResult<Mappable>
public typealias StatusCode = Int
public typealias NetworkServiceResponse<T: Mappable> = (_ result: NetworkResponseResult, _ statusCode: StatusCode, _ json: JSON?, _ response: Moya.Response?, _ type: NetworkResponseType) -> Void

//============================================================================
//============================================================================
// MARK: - enum

public enum NetworkResponseType {
    case object
    case array
    case primative

}

open class NetworkService: NSObject {

    open static var shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()

    open class func reset() {
        let newInstance = NetworkService()
        NetworkService.shared = newInstance
    }
    private lazy var mainProvider = APIProvider { () -> String in
        if let accesstoken = NetworkDefault.accessToken {
            return   accesstoken()
        }
        return ""
        }.provider

    /// reauthenticate all intialized Providers
    func authenticateProviders() {

    }

    internal func request<E: TargetType, T: Mappable>(endPoint: E, modelType: T.Type, responseType: NetworkResponseType = .object, delegate: @escaping NetworkServiceResponse<T>) {

        if let provider = self.mainProvider {
            provider.request(MultiTarget(endPoint)) { moyaResult in

                self.responseHandeler(moyaResult, modelType: modelType, responseType, delegate: delegate)
            }

        } else {
            let error = NSError(domain: "io.networkservice.error",
                                code: -999,
                                userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("network_provider_is_nil",
                                                                                        comment: "main Network Provider not found")])
            delegate(NetworkResult.networkFailure(MoyaError.underlying(error, nil)), 0, nil, nil, responseType)
        }

    }

    private func responseHandeler <T: Mappable>(_ result: Result<Moya.Response, Moya.MoyaError>, modelType: T.Type, _ responseType: NetworkResponseType, delegate: @escaping NetworkServiceResponse<T>) {

        switch result {
        case let .success(response):
            if (200...299 ~= response.statusCode) {
                self.successHandler(modelType, response: response, delegate: delegate)
            } else {

                self.serverFailureHandler(modelType, response: response, delegate: delegate)
            }

            break

        case let .failure(error):

            self.networkFailureHandler(modelType, error: error, response: nil, delegate: delegate)

        }

        self.debuger()

    }

    private func successHandler<T: Mappable> (_ modelType: T.Type, response: Moya.Response, _ type: NetworkResponseType = .object, delegate: @escaping NetworkServiceResponse<T>) {

        var json: JSON? = nil
        var model: Mappable!

        do {
            json = try JSON(data: response.data)

            switch type {
            case .object:
                model = try response.mapObject(GenaricModel<T>.self)

            case .array:
                model = try response.mapObject(GenaricArray<T>.self)

            case .primative:
                model = try response.mapObject(GenaricType<T>.self)

                //            default:
                //                fatalError(" requesting to map Network response to type not implemented ")
                //                break;
            }
        } catch let parseError {
            #if DEBUG
            print(parseError.localizedDescription)
            #endif

            delegate(NetworkResult.networkFailure(parseError), response.statusCode, json, response, type)
            return
        }

        delegate(NetworkResult.success(model), response.statusCode, json, response, type)

    }

    private func serverFailureHandler<T: Mappable> (_ modelType: T.Type, response: Moya.Response, _ type: NetworkResponseType = .object, delegate: @escaping NetworkServiceResponse<T>) {

        var json: JSON? = nil

        var serverErrors: [ErrorModel]?
        do {
            json = try JSON(data: response.data)
            let errorResposne = try response.mapObject(GenaricModel<ErrorWrapper>.self)
            serverErrors = errorResposne.response?.errors
        } catch let parseError {
            #if DEBUG
            print(parseError.localizedDescription)
            #endif

            delegate(NetworkResult.networkFailure(MoyaError.requestMapping(parseError.localizedDescription)), response.statusCode, json, response, type)
        }
        delegate(NetworkResult.serverFailure(serverErrors), response.statusCode, json, response, type)

    }

    private func networkFailureHandler<T: Mappable> (_ modelType: T.Type, error: MoyaError, response: Moya.Response?, _ type: NetworkResponseType = .object, delegate: @escaping NetworkServiceResponse<T>) {

        var json: JSON? = nil
        do {
            if let data = response?.data {
                json = try JSON(data: data)
            }
        } catch let parseError {
            #if DEBUG
            print(parseError.localizedDescription)
            #endif

            delegate(NetworkResult.networkFailure(MoyaError.requestMapping(parseError.localizedDescription)), response?.statusCode ?? 0, json, response, type)
        }

        delegate(NetworkResult.networkFailure(error), response?.statusCode ?? 0, json, response, type)

    }

    /// add `NetworkStack` to your schema launch command argument to print call stack
    private func debuger() {

        CommandLine.arguments.forEach({ (argument) in

            switch argument {
            case "NetworkStack":
                print(Thread.callStackSymbols.forEach { print($0) })
                break
            default:
                break

            }
        })

    }

}
