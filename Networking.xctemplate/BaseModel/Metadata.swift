//
//	Metadata.swift
//  PME_iOS
//
//  Created Bassem Abbas on 2/13/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper

//swiftlint:disable all

open class Metadata: NSObject, NSCoding, Mappable {
    var count: Int?
    var currentPage: Int?
    var entity: String?
    var hasMorePages: Bool?
    var itemPerPage: Int?
    var page: Int?
    var totalCount: Int?

    class func newInstance(map: Map) -> Mappable? {
        return Metadata()
    }
    required public init?(map: Map) {}
    private override init() {}

    public func mapping(map: Map) {
        count           <- map["count"]
        currentPage     <- map["currentPage"]
        entity          <- map["entity"]
        hasMorePages    <- map["hasMorePages"]
        itemPerPage     <- map["itemPerPage"]
        page            <- map["page"]
        totalCount      <- map["totalCount"]

    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        count          = aDecoder.decodeObject(forKey: "count") as? Int
        currentPage    = aDecoder.decodeObject(forKey: "currentPage") as? Int
        entity         = aDecoder.decodeObject(forKey: "entity") as? String
        hasMorePages   = aDecoder.decodeObject(forKey: "hasMorePages") as? Bool
        itemPerPage    = aDecoder.decodeObject(forKey: "itemPerPage") as? Int
        page           = aDecoder.decodeObject(forKey: "page") as? Int
        totalCount     = aDecoder.decodeObject(forKey: "totalCount") as? Int

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if count != nil {
            aCoder.encode(count, forKey: "count")
        }
        if currentPage != nil {
            aCoder.encode(currentPage, forKey: "currentPage")
        }
        if entity != nil {
            aCoder.encode(entity, forKey: "entity")
        }
        if hasMorePages != nil {
            aCoder.encode(hasMorePages, forKey: "hasMorePages")
        }
        if itemPerPage != nil {
            aCoder.encode(itemPerPage, forKey: "itemPerPage")
        }
        if page != nil {
            aCoder.encode(page, forKey: "page")
        }
        if totalCount != nil {
            aCoder.encode(totalCount, forKey: "totalCount")
        }

    }

}
