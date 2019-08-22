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

public typealias NetworkResult<T> = Result< T, NetworkError >

public enum NetworkError: Error {
    case networkFailure(_ error: ErrorModel?)
    case serverFailure(_ error: ErrorModel?)
    case parsingFailure(_ error: ErrorModel?)

    var error: ErrorModel? {
        switch self {
        case .networkFailure(let model):
            return model

        case .serverFailure(let model):
            return model

        case .parsingFailure(let model):
            return model
        }
    }
}
