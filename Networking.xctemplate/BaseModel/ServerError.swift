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

//swiftlint:disable all

internal typealias ErrorInfo = [String:Any]

open class ErrorWrapper: BaseResponse {

    var error: ErrorModel?

    class func newInstance(map: Map) -> ErrorWrapper? {
        return ErrorWrapper()
    }
    required public init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    @objc public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func mapping(map: Map) {

        error <- map["error"]

    }
}

public class ErrorModel: NSObject, NSCoding, Mappable {


	enum ErrorKind {
		case networkFailure
		case serverFailure
		case parsingFailure
	}

	
    //var type: NetworkError = .serverFailure(error: nil)
    var errorInfo: ErrorInfo?
    var code: Int?
    var key: String?
    var message: String?
    var underlyingError: NSError?
	var type: ErrorKind = .networkFailure
	init(message: String,kind: ErrorKind, key: String?, code: Int?) {

		self.message = message
		self.type = kind
		self.key = key
		self.code = code
    }

	init(_ error: NSError , kind: ErrorKind ) {

		self.type = kind
        underlyingError = error
        message = error.localizedDescription
        code = error.code
        errorInfo = error.userInfo
    }

    init(_ error: Error,  kind: ErrorKind ) {
        //		if error is MoyaError {
        //
        //		}
		type = kind
        if let nsError = error as? NSError {
            underlyingError = nsError
            message = error.localizedDescription
            key = nsError.userInfo[NSLocalizedDescriptionKey] as? String
            code = nsError.code
            errorInfo = nsError.userInfo
        } else {

        }
    }

    class func newInstance(map: Map) -> Mappable? {
        return ErrorModel()
    }

    public var localizedDescription: String {

        //should check if message is in displayed app language else try loclized the  key if not exist return message
        return ""
    }

    required public init?(map: Map) {
		type = .networkFailure
	}
    private override init() {
		type = .networkFailure
	}

    public func mapping(map: Map) {
        errorInfo   <- map["info"]
        code        <- map["code"]
        key         <- map["key"]
        message     <- map["message"]
        underlyingError     <- map["error"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        errorInfo   = aDecoder.decodeObject(forKey: "info") as? ErrorInfo
        code        = aDecoder.decodeObject(forKey: "code") as? Int
        key         = aDecoder.decodeObject(forKey: "key") as? String
        message     = aDecoder.decodeObject(forKey: "message") as? String
        underlyingError     = aDecoder.decodeObject(forKey: "error") as? NSError

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if errorInfo != nil {
            aCoder.encode(errorInfo, forKey: "info")
        }
        if code != nil {
            aCoder.encode(code, forKey: "code")
        }
        if key != nil {
            aCoder.encode(key, forKey: "key")
        }
        if message != nil {
            aCoder.encode(message, forKey: "message")
        }

        if underlyingError != nil {
            aCoder.encode(underlyingError, forKey: "error")
        }
    }

}



extension ErrorModel: Error {

}
extension ErrorModel {

    private static let UnknownErrorMessage: String = NSLocalizedString("error_unknown", tableName: "URLErrors", comment: "unknown error")

    public struct  CommonErrors {

		public static let noInternet = ErrorModel.customizeErrorMessage(error: NSError(domain: "com.antame", code: NSURLErrorNotConnectedToInternet, userInfo: nil))
        public static let  getData  =  ErrorModel(message: NSLocalizedString("error_get_data", tableName: "URLErrors", comment: "NSURLErrorTimedOut Message"), kind: .networkFailure, key: nil, code: nil)

        public static let  unknownError  =  ErrorModel(message: NSLocalizedString("error_unknown", tableName: "URLErrors", comment: "unknown error"), kind: .networkFailure, key: nil, code: nil)
        public static let  invalidShareData  =  ErrorModel(message: NSLocalizedString("error_share_data", tableName: "Errors", comment: "share  data is not valid"), kind: .networkFailure, key: nil, code: nil)

    }
}

extension ErrorModel {
    /// customize Error Message for some errors

//    public class func customizeError(error: Error) -> ErrorModel {
//
//        let networkError: ErrorModel
//        if  let moyaError = error as? MoyaError {
//
//            switch moyaError {
//
//            case .underlying(let anError, _):
//                networkError = ErrorModel(message: customizeErrorMessage(error: anError), key: nil, code: (anError as NSError).code)
//                //                networkError.error = anError
//                //                networkError.type = .noInternet
//                break
//            default:
//
//                networkError = ErrorModel(message: error.localizedDescription, key: nil, code: (error as NSError).code)
//                break
//            }
//
//        } else    {
//            networkError = ErrorModel(message: customizeErrorMessage(error: (error as NSError)), key: nil, code: (error as NSError).code)
//            //            networkError.error = error
//            //            networkError.type = .noInternet
//        }
//
//        return  networkError
//
//    }

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

        let error = ErrorModel(message: NSLocalizedString("error_get_data", tableName: "URLErrors", comment: "failed to fetch data from internet , internal error"),kind: .networkFailure, key: nil, code: nil)

        return error

    }
}

extension NSError {
	func isNetworkConnectionError() -> Bool {
		let networkErrors = [NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet]

		if self.domain == NSURLErrorDomain && networkErrors.contains(self.code) {
			return true
		}
		return false
	}
}
