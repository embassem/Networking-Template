//
//	BaseResponse.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

//swiftlint:disable all

open class BaseResponse: NSObject, NSCoding, Mappable {

    public var metadata: Metadata?

    class func newInstance(map: Map) -> Mappable? {
        return BaseResponse()
    }
    required public init?(map: Map) {}
    override init() {}

    open func mapping(map: Map) {
        metadata <- map["metadata"]
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        metadata = aDecoder.decodeObject(forKey: "metadata") as? Metadata
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if metadata != nil {
            aCoder.encode(metadata, forKey: "metadata")
        }
    }

}
