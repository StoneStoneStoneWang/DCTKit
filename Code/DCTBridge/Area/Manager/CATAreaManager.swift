//
//  CATAreaManager.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import CATBean
import CATYY
import RxCocoa
import WLBaseResult
import RxSwift
import CATReq
import WLReqKit
import CATApi
import Alamofire
import CATRReq

@objc (CATAreaManager)
public class CATAreaManager: NSObject {
    
    @objc (shared)
    public static let `default`: CATAreaManager = CATAreaManager()
    
    private override init() { }
    // 全部地区
    @objc public var allAreas: [CATAreaBean] = []
}

extension CATAreaManager {
    
      public func fetchAreas() -> Driver<WLBaseResult> {
        
        if allAreas.count > 0 {
            
            return Driver.just(WLBaseResult.fetchList(allAreas))
        } else {
            
            if isAreaFileExist() {
                
                let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
                
                let targetPath = cachePath + "/Areas"
                
                if let arr = NSArray(contentsOfFile: targetPath) {
                    
                    var mutable: [CATAreaBean] = []
                    
                    for item in arr {
                        
                        mutable += [CATAreaBean(JSON: item as! [String: Any])!]
                    }
                    
                    allAreas += mutable
                    
                    return Driver.just(WLBaseResult.fetchList(mutable))
                }
                
                return Driver.just(WLBaseResult.failed("获取本地数据失败!"))
            } else {
                
                return CATAreaResp(CATApi.fetchAreaJson)
                    .map({ CATAreaManager.default.saveArea($0) })
                    .map({ _ in WLBaseResult.fetchList(CATAreaManager.default.allAreas)  })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            }
        }
    }
    
   @objc public func fetchSomeArea(_ id: Int)  -> CATAreaBean {
        
        assert(allAreas.count > 0, "请先调用 fetchArea")
        
        var result: CATAreaBean!
        
        for item in allAreas {
            
            if item.areaId == id {
                
                result = item
                
                break
            }
        }
        
        return result ?? CATAreaBean()
    }
    
   @objc public func saveArea(_ areas: [Any]) -> [Any] {
        
        for item in areas {
            
            allAreas += [CATAreaBean(JSON: item as! [String: Any])!]
        }
        
        let mutable = NSMutableArray()
        
        mutable.addObjects(from: areas)
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        mutable.write(toFile: targetPath, atomically: true)
        
        return areas
    }
    
    public func isAreaFileExist() -> Bool {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        return FileManager.default.fileExists(atPath: targetPath)
    }
}
