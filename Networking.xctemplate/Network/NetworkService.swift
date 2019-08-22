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


//swiftlint:disable all

import enum Result.Result
//typealias NetworkServiceResponse = ( _ model: Mappable?,
//    _ error:Swift.Error?,
//    _ data: JSON?,
//    _ response: Response?  ) -> Void

//============================================================================
//============================================================================
// MARK: - typealias

public typealias NetworkResponseResult = NetworkResult<Mappable>
public typealias StatusCode = Int
public typealias NetworkServiceResponse<T: Mappable> = (_ result: NetworkResponseResult,
    _ statusCode: StatusCode,
    _ json: JSON?,
    _ response: Moya.Response?,
    _ type: NetworkResponseType) -> Void

//============================================================================
//============================================================================
// MARK: - enum

public enum NetworkResponseType {
    case object
    case array
    case rootObject
    case rootArray
    case primative

}

open class NetworkService: NSObject {
    public static var shared: NetworkService = {
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

    internal func request<E: TargetType, T: Mappable>(endPoint: E,
                                                      modelType: T.Type,
                                                      responseType: NetworkResponseType = .object,
                                                      delegate: @escaping NetworkServiceResponse<T>) {

        if let provider = self.mainProvider {
            provider.request(MultiTarget(endPoint)) { moyaResult in

                self.responseHandeler(moyaResult, modelType: modelType, responseType, delegate: delegate)
            }

        } else {
            let error = NSError(domain: "io.networkservice.error",
                                code: -999,
                                userInfo: [NSLocalizedDescriptionKey:
                                    NSLocalizedString("network_provider_is_nil",
                                                      comment: "main Network Provider not found")
                ]
            )
            delegate(NetworkResult.failure(
                NetworkError.networkFailure( ErrorModel(error ,kind: .networkFailure))),
                     0,
                     nil,
                     nil,
                     responseType)
        }

    }

    private func responseHandeler <T: Mappable>(_ result: Result<Moya.Response, Moya.MoyaError>,
                                                modelType: T.Type,
                                                _ responseType: NetworkResponseType,
                                                delegate: @escaping NetworkServiceResponse<T>) {

        switch result {
        case let .success(response):
            if 200...299 ~= response.statusCode {
                self.successHandler(modelType: modelType, response: response,type: responseType, delegate: delegate)
            } else {

                self.serverFailureHandler(modelType, response: response, delegate: delegate)
            }

        case let .failure(error):

            self.networkFailureHandler(modelType, error: error, response: nil, delegate: delegate)

        }

        self.debugger()

    }

    private func successHandler<T: Mappable> ( modelType: T.Type,
                                               response: Moya.Response,
                                               type: NetworkResponseType = .object,
                                               delegate: @escaping NetworkServiceResponse<T>) {

        var json: JSON?
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

            case .rootObject:
                let objectModel = try response.mapObject(T.self)
                print(objectModel)
                model = GenaricModel(data: objectModel)
                print(model)
            case .rootArray:
                let arrayModel = try response.mapArray(T.self)
                model = GenaricArray<T>(arrayModel)
            }
        } catch let parseError {
            #if DEBUG
            print(parseError.localizedDescription)
            #endif

            delegate(NetworkResult.failure(.parsingFailure(ErrorModel(parseError, kind: .parsingFailure))),
                     response.statusCode,
                     json,
                     response,
                     type)
            return
        }

        delegate(NetworkResult.success(model), response.statusCode, json, response, type)

    }

    private func serverFailureHandler<T: Mappable> (_ modelType: T.Type,
                                                    response: Moya.Response,
                                                    _ type: NetworkResponseType = .object,
                                                    delegate: @escaping NetworkServiceResponse<T>) {

        var json: JSON?

        var serverError: ErrorModel?
        do {
            json = try JSON(data: response.data)
            let errorResposne = try response.mapObject(GenaricModel<ErrorWrapper>.self)
            serverError = errorResposne.data?.error
        } catch let parseError {
            #if DEBUG
            print(parseError.localizedDescription)
            #endif

            delegate(NetworkResult.failure(.parsingFailure(ErrorModel(parseError, kind: .parsingFailure))),
                     response.statusCode,
                     json,
                     response,
                     type)
        }
        delegate(NetworkResult.failure(.serverFailure(serverError)), response.statusCode, json, response, type)

    }

    private func networkFailureHandler<T: Mappable> (_ modelType: T.Type,
                                                     error: MoyaError,
                                                     response: Moya.Response?,
                                                     _ type: NetworkResponseType = .object,
                                                     delegate: @escaping NetworkServiceResponse<T>) {

        var json: JSON?
        do {
            if let data = response?.data {
                json = try JSON(data: data)
            }
        } catch let parseError {
            #if DEBUG
            print(parseError.localizedDescription)
            #endif

            delegate(NetworkResult.failure(.parsingFailure(ErrorModel(parseError, kind: .parsingFailure))),
                     response?.statusCode ?? 0, json,
                     response, type)
        }

        delegate(NetworkResult.failure(.networkFailure(ErrorModel(error, kind: .networkFailure))), response?.statusCode ?? 0, json, response, type)

    }

    /// add `NetworkStack` to your schema launch command argument to print call stack
    private func debugger() {

        CommandLine.arguments.forEach({ (argument) in

            switch argument {
            case "NetworkStack":
                print(Thread.callStackSymbols.forEach { print($0) })

            default:
                break

            }
        })

    }

}