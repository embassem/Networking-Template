//
//	BaseModel.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseModel: NSObject, NSCoding, Mappable {

    public var code: String?
    public var status: String?
    public var message: String?
    class func newInstance(map: Map) -> Mappable? {
        return BaseModel()
    }
    required public init?(map: Map) {}
    override init() {}

    open func mapping(map: Map) {

        status <- map["status"]
        code <- map["code"]
        message <- map["message"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {

        code = aDecoder.decodeObject(forKey: "code") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {

        if code != nil {
            aCoder.encode(code, forKey: "code")
        }
        if status != nil {
            aCoder.encode(status, forKey: "status")
        }
    }

}
