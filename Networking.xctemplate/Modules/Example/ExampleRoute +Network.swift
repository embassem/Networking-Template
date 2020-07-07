//
//  Campains+Network.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya

protocol ExampleRouteService {
    func getExample(completion: @escaping (
        _ result: Swift.Result<APIResponse<Example>, APIError>,
        _ statusCode: StatusCode?
        ) -> Void)
}

extension NetworkManager: ExampleRouteService {
    
    func getExample(completion: @escaping (
        _ result: Swift.Result<APIResponse<Example>, APIError>,
        _ statusCode: StatusCode?
        ) -> Void) {
        
        provider.request(MultiTarget(ExampleRoute.getExample)) { (result) in
            self.parseResponse(moyaResult: result, completion: completion)
        }
    }
}

