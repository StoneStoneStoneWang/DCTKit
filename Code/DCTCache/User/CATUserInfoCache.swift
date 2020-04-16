//
//  CATUserInfoCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATBean
import CATYY

@objc (CATUserInfoCache)
public final class CATUserInfoCache: NSObject {
    @objc (shared)
    public static let `default`: CATUserInfoCache = CATUserInfoCache()
    
    private override init() {
        
        if let info = Bundle.main.infoDictionary {
            
            CATYY.shared().createCache(info["CFBundleDisplayName"] as? String ?? "CATUserInfoCache" )
        }
    }
    @objc (userBean)
    public dynamic var userBean: CATUserBean = CATUserBean()
}

extension CATUserInfoCache {
    
    public func saveUser(data: CATUserBean) -> CATUserBean {
        
        if CATAccountCache.default.uid != "" {
            
            CATYY.shared().saveObj(data, withKey: "user_" + CATAccountCache.default.uid)
            
            userBean = data
        }
        
        return data
    }
    
    public func queryUser() -> CATUserBean  {
        
        if CATAccountCache.default.uid != "" {
            
            if let user = CATYY.shared().fetchObj("user_" + CATAccountCache.default.uid) {
                
                userBean = user as! CATUserBean
                
                return userBean
            }
        }
    
        return CATUserBean()
    }
}
