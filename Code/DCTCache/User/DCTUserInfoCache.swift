//
//  DCTUserInfoCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTBean
import DCTYY

@objc (DCTUserInfoCache)
public final class DCTUserInfoCache: NSObject {
    @objc (shared)
    public static let `default`: DCTUserInfoCache = DCTUserInfoCache()
    
    private override init() {
        
        if let info = Bundle.main.infoDictionary {
            
            DCTYY.shared().createCache(info["CFBundleDisplayName"] as? String ?? "DCTUserInfoCache" )
        }
    }
    @objc (userBean)
    public dynamic var userBean: DCTUserBean = DCTUserBean()
}

extension DCTUserInfoCache {
    
    public func saveUser(data: DCTUserBean) -> DCTUserBean {
        
        if DCTAccountCache.default.uid != "" {
            
            DCTYY.shared().saveObj(data, withKey: "user_" + DCTAccountCache.default.uid)
            
            userBean = data
        }
        
        return data
    }
    
    @objc public func queryUser() -> DCTUserBean  {
        
        if DCTAccountCache.default.uid != "" {
            
            if let user = DCTYY.shared().fetchObj("user_" + DCTAccountCache.default.uid) {
                
                userBean = user as! DCTUserBean
                
                return userBean
            }
        }
        
        return DCTUserBean()
    }
}
