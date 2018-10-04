//
//  ServerError.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

open class ErrorWrapper: NSObject, Mappable {
    public var errors: [ErrorModel]?

    class func newInstance(map: Map) -> Mappable? {
        return ErrorWrapper()
    }
    required public init?(map: Map) {}
    override init() {}

    public func mapping(map: Map) {

        errors <- map["errors"]

    }
}

public enum ErrorType {
    case unknown
    case noInternet
    case serverError
}

open class ErrorModel: NSObject, Mappable {

    public var field: String?
    public var code: Int?
    public var message: String?
    public var error: Error?
    public var type: ErrorType = .unknown

    class func newInstance(map: Map) -> Mappable? {
        return BaseModel()
    }
    required public init?(map: Map) {}
    override init() {}

    public func mapping(map: Map) {

        message <- map["msg"]
        code <- map["code"]
        field <- map["field"]
        error <- map["error"]
        type <- map["type"]

    }

    public init(message: String?, field: String?, code: Int?) {
        self.message = message
        self.code = code
        self.field = field
    }
}

extension ErrorModel: Error {
}
extension ErrorModel {

    public static let UnknownErrorMessage: String = NSLocalizedString("error_unknown", tableName: "URLErrors", comment: "unknown error")

    public struct  CommonErrors {

        public static let noInternet = ErrorModel.customizeError(error: NSError(domain: "com.antame", code: NSURLErrorNotConnectedToInternet, userInfo: nil))
        public static let  getData  =  ErrorModel(message: NSLocalizedString("error_get_data", tableName: "URLErrors", comment: "NSURLErrorTimedOut Message"), field: nil, code: 0)

        public static let  unknownError  =  ErrorModel(message: NSLocalizedString("error_unknown", tableName: "URLErrors", comment: "unknown error"), field: nil, code: 0)
        public static let  invalidShareData  =  ErrorModel(message: NSLocalizedString("error_share_data", tableName: "Errors", comment: "share  data is not valid"), field: nil, code: 0)

    }
}

extension ErrorModel {
    /// customize Error Message for some errors

    public class func customizeError(error: Error) -> ErrorModel {

        let networkError: ErrorModel
        if  let moyaError = error as? MoyaError {

            switch moyaError {

            case .underlying(let anError, _):
                networkError = ErrorModel(message: customizeErrorMessage(error: anError), field: nil, code: (anError as NSError).code)
                networkError.error = anError
                networkError.type = .noInternet
                break
            default:

                networkError = ErrorModel(message: error.localizedDescription, field: nil, code: (error as NSError).code)
                break
            }

        } else if ( error is NSError) {
            networkError = ErrorModel(message: customizeErrorMessage(error: error), field: nil, code: (error as NSError).code)
            networkError.error = error
            networkError.type = .noInternet
        } else {
            networkError = CommonErrors.getData
        }

        return  networkError

    }

    internal class func customizeErrorMessage(error: Error) -> String {

        let nsError = error as NSError
        let customMessage: String
        switch nsError.code {
        case  NSURLErrorTimedOut, NSURLErrorNotConnectedToInternet:
            customMessage = NSLocalizedString("error_no_internet", comment: "NSURLErrorTimedOut Message")
        default:
            customMessage = error.localizedDescription
        }
        return customMessage
    }
    public class func unknownError() -> ErrorModel {

        let error = ErrorModel(message: NSLocalizedString("error_get_data", tableName: "URLErrors", comment: "failed to fetch data from internet , internal error"), field: nil, code: 0)

        return error

    }
}
