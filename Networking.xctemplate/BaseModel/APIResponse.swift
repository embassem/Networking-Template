//
//  APIResponse.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation

// MARK: - APIResponse
struct APIResponse<T:Codable> : Codable {

    var data : T?
    let status : Int?
    let success : Bool?
    let error: APIError?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
        case success = "success"
        case error = "error"
        case message  = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(T.self, forKey: .data)//try T(from: decoder)
        error = try values.decodeIfPresent(APIError.self, forKey: .error)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        if data is String, data == nil, let msg =  message as? T {
            data = msg
        }
    }
}
