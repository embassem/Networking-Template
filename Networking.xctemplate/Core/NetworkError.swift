//
//  NetworkError.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya

enum `Type`:String, Codable {
    case business
    case system
    case mapping
}

struct APIError: Codable, Error, LocalizedError {
    
    //enum (busineess , system , mapping) will know from moya error by (type / status code)
    var code: Int?
    var key: String?
    var message: String?
    var type: Type?
    var fields: [String: String]?
    
    var underling: Error?
    //    var userInfo: [String: Any] = [:]
    
    init () {
        
    }
    
    init(error: MoyaError) {
        self.underling = error
        self.code = error.errorCode
        self.message = error.errorDescription
        
        switch error {
        case .underlying(let error, _):
            self.type = .system
            print(error)
        //            userInfo["error"] = error
        default :
            self.type = .mapping
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case key = "code"
        case code = "key"
        case fields = "fields"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        fields = try values.decodeIfPresent([String:String].self, forKey: .fields)
    }
    
    func innerErrorMessage() -> (title:String? , message:String?) {
        let title = self.message
        if let fields = fields {
            let message = Array(fields.values).map({ "- \($0)\n"}).joined(separator: "")
            return (title, message)
        }
        return (title, nil)
    }
    
    var errorDescription: String? {
        if self.code == 422{
            return innerErrorMessage().message
        }
        return self.message
    }
}

extension APIError {
    static let parseError: APIError = {
        var error = APIError()
        error.type = Type.mapping
        return error
    }()
    
    static let genaricError: APIError = {
        var error = APIError()
        error.type = Type.business
        return error
    }()
}
