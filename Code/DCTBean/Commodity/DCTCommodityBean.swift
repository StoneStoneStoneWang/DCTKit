//
//  DCTCommodityBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import WLToolsKit

@objc (DCTCommodityBean)
public class DCTCommodityBean: NSObject, Mappable , IdentifiableType{
    
    public var identity: String = ""
    
    public typealias Identity = String
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        
        identity <- map["encoded"]
        
        intime <- map["intime"]
        
        content  <- map["content"]
        
        isLaud  <- map["isLaud"]
        
        countLaud  <- map["countLaud"]
        
        tag  <- map["tag"]
        
        users  <- map["users"]
        
        countComment  <- map["countComment"]
        
        projectId  <- map["projectId"]
        
        encoded  <- map["encoded"]
    }
    
    @objc public var projectId: String = ""
    
    @objc public var encoded: String = ""
    
    @objc public var intime: Int = Int.max
    
    @objc public var content: String = ""
    
    @objc public var isLaud: Bool = false
    
    @objc public var countLaud: Int = Int.max
    
    @objc public var tag: String = ""
    
    @objc public var users: DCTUserBean!
    
    @objc public var countComment: Int = Int.max
    
    @objc public var contentMap: [DCTKeyValueBean] {
        
        let res = WLJsonCast.cast(argu: content) as! [[String: String]]
        
        return res.map({ DCTKeyValueBean(JSON: $0)! })
    }
    
    @objc public var imgs: [DCTKeyValueBean] {
        
        var result: [DCTKeyValueBean] = []
        
        for item in contentMap {
            
            if item.type == "image" {
                
                result += [item]
            }
        }
        
        if result.isEmpty {
            
            for item in contentMap {
                
                if item.type == "txt" && item.value.contains("Image:") {
                    
                    result += [item]
                }
            }
        }
        
        return result
    }
}
