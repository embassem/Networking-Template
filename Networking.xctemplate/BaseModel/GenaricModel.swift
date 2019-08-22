//
//  GenaricModel.swift
//  PME_iOS
//
//  Created Bassem Abbas on 2/13/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

//swiftlint:disable all

open class GenaricModel<T: Mappable> : BaseResponse {

    public var data: T?

    override class func newInstance(map: Map) -> Mappable? {
        return GenaricModel<T>()
    }
    public required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    init(_ object: T) {
        super.init()
    }

    init(data: T) {
        super.init()
        self.data = data
    }
    override open func mapping(map: Map) {
        super.mapping(map: map)

        data <- map["data"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        data = aDecoder.decodeObject(forKey: "data") as? T

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        if data != nil {
            aCoder.encode(data, forKey: "data")
        }

    }
}

open class GenaricArray<T: Mappable> : BaseResponse {

    public var data: [T]?

    override class func newInstance(map: Map) -> Mappable? {
        return GenaricArray<T>()
    }
    required public  init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    init(_ array: [T]) {
        super.init()
        self.data = array
    }

    override open func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        data = aDecoder.decodeObject(forKey: "data") as?  [T]

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        if data != nil {
            aCoder.encode(data, forKey: "data")
        }

    }
}

open class GenaricType<T: Any> : BaseResponse {

    public var data: T?

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

        data <- map["data"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        data = aDecoder.decodeObject(forKey: "data") as? T

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        if data != nil {
            aCoder.encode(data, forKey: "data")
        }

    }
}
