//
//  NetworkDefault.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
public struct NetworkDefault {
    static public  let pageCount: Int = 10
    static public  let timeoutIntervalForRequest: TimeInterval = 30 // as seconds, you can set your request timeout
    static public  let timeoutIntervalForResource: TimeInterval = 30
    static public  var baseURL = ""
    static public  var verbose = false
    static public  var apiKey = ""
    static public var  accessToken: (() -> String)?
}
