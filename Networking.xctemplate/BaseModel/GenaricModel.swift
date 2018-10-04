//
//  GenaricModel.swift
//  ___PROJECTNAME___/Networking
//
//  Created by Bassem Abbas on 4/12/18.
//  Copyright © ___YEAR___ Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

open class GenaricModel<T: Mappable> : BaseModel {

    public var response: T?

    override class func newInstance(map: Map) -> Mappable? {
        return GenaricModel<T>()
    }
    public required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    init(response: T) {
        super.init()
        self.response = response
    }
    override open func mapping(map: Map) {
        super.mapping(map: map)

        response <- map["response"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        response = aDecoder.decodeObject(forKey: "response") as? T

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        if response != nil {
            aCoder.encode(response, forKey: "response")
        }

    }
}
open class GenaricArray<T: Mappable> : BaseModel {

    public var response: [T]?

    override class func newInstance(map: Map) -> Mappable? {
        return GenaricArray<T>()
    }
    required public  init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    override open func mapping(map: Map) {
        super.mapping(map: map)
        response <- map["response"]
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        response = aDecoder.decodeObject(forKey: "response") as?  [T]

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        if response != nil {
            aCoder.encode(response, forKey: "response")
        }

    }
}

open class GenaricType<T: Any> : BaseModel {

    public var response: T?

    override class func newInstance(map: Map) -> Mappable? {
        return GenaricType<T>()
    }
    required public init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    override open func mapping(map: Map) {
        super.mapping(map: map)

        response <- map["response"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        response = aDecoder.decodeObject(forKey: "response") as? T

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        if response != nil {
            aCoder.encode(response, forKey: "response")
        }

    }
}
