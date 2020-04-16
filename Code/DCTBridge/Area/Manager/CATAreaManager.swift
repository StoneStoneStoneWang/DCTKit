//
//  DCTAreaManager.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTBean
import DCTYY
import RxCocoa
import DCTResult
import RxSwift
import DCTReq

import DCTApi
import Alamofire
import DCTRReq

@objc (DCTAreaManager)
public class DCTAreaManager: NSObject {
    
    @objc (shared)
    public static let `default`: DCTAreaManager = DCTAreaManager()
    
    private override init() { }
    // 全部地区
    @objc public var allAreas: [DCTAreaBean] = []
}

extension DCTAreaManager {
    
      public func fetchAreas() -> Driver<DCTResult> {
        
        if allAreas.count > 0 {
            
            return Driver.just(DCTResult.fetchList(allAreas))
        } else {
            
            if isAreaFileExist() {
                
                let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
                
                let targetPath = cachePath + "/Areas"
                
                if let arr = NSArray(contentsOfFile: targetPath) {
                    
                    var mutable: [DCTAreaBean] = []
                    
                    for item in arr {
                        
                        mutable += [DCTAreaBean(JSON: item as! [String: Any])!]
                    }
                    
                    allAreas += mutable
                    
                    return Driver.just(DCTResult.fetchList(mutable))
                }
                
                return Driver.just(DCTResult.failed("获取本地数据失败!"))
            } else {
                
                return DCTAreaResp(DCTApi.fetchAreaJson)
                    .map({ DCTAreaManager.default.saveArea($0) })
                    .map({ _ in DCTResult.fetchList(DCTAreaManager.default.allAreas)  })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
            }
        }
    }
    
   @objc public func fetchSomeArea(_ id: Int)  -> DCTAreaBean {
        
        assert(allAreas.count > 0, "请先调用 fetchArea")
        
        var result: DCTAreaBean!
        
        for item in allAreas {
            
            if item.areaId == id {
                
                result = item
                
                break
            }
        }
        
        return result ?? DCTAreaBean()
    }
    
   @objc public func saveArea(_ areas: [Any]) -> [Any] {
        
        for item in areas {
            
            allAreas += [DCTAreaBean(JSON: item as! [String: Any])!]
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
