//
//  UserRoute.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//


import Moya
import Foundation


enum ExampleRoute {
    case getExample
}

extension UserRoute: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return URL(string: NetworkManager.shared.networkConfig.baseUrl)!
    }
    
    var path: String {
        
        switch self {
        case .getExample:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}
