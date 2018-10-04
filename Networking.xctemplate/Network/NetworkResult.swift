//
//  NetworkResult.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya
import Result

public enum NetworkResult<Value>: CustomStringConvertible, CustomDebugStringConvertible {

    case success(Value)
    case networkFailure(Swift.Error)
    case serverFailure([ErrorModel]?)

    // MARK: Constructors

    /// Constructs a success wrapping a `value`.
    public init(value: Value) {
        self = .success(value)
    }

    public init(_ errors: [ErrorModel]?) {
        self = .serverFailure(errors)
    }

    /// Constructs a failure wrapping an `error`.
    public init(error: Error) {
        self = .networkFailure(error)
    }

    /// Constructs a result from an `Optional`, failing with `Error` if `nil`.
    public init(_ value: Value?, failWith: @autoclosure () -> Error) {
        self = value.map(NetworkResult.success) ?? .networkFailure(failWith())
    }

    // MARK: Errors

    /// The domain for errors constructed by Result.
    public static var errorDomain: String { return "com.antitypical.Result" }

    /// The userInfo key for source functions in errors constructed by Result.
    public static var functionKey: String { return "\(errorDomain).function" }

    /// The userInfo key for source file paths in errors constructed by Result.
    public static var fileKey: String { return "\(errorDomain).file" }

    /// The userInfo key for source file line numbers in errors constructed by Result.
    public static var lineKey: String { return "\(errorDomain).line" }

    /// Constructs an error.
    public static func error(_ message: String? = nil, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        var userInfo: [String: Any] = [
            functionKey: function,
            fileKey: file,
            lineKey: line
        ]

        if let message = message {
            userInfo[NSLocalizedDescriptionKey] = message
        }

        return NSError(domain: errorDomain, code: 0, userInfo: userInfo)
    }

    // MARK: CustomStringConvertible

    public var description: String {
        switch self {
        case let .success(value): return ".success(\(value))"
        case let .networkFailure(error): return ".networkFailure(\(error))"
        case let .serverFailure(errors): return ".networkFailure(\(errors))"
        }
    }

    // MARK: CustomDebugStringConvertible

    public var debugDescription: String {
        return description
    }

}
