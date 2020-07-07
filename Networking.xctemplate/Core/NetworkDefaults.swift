//
//  NetworkDefaults.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation

struct NetworkDefaults {
    
    var baseUrl: String = "https://example.com"
    var clientID: String = ""
	var clientSecret : String = ""
    var accessToken: (()-> String)
    
    static var `defaults` : NetworkDefaults {
        let instance = NetworkDefaults(accessToken: { return PersistenceManager.getUserTokenAuth()?.accessToken ?? "" })
        return instance
    }
}
